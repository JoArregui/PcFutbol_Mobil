import 'dart:math';
import 'package:isar/isar.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import '../models/transfer_offer.dart';
import '../models/team.dart';
import '../models/game_message.dart';
import 'message_service.dart';


/// Servicio avanzado para gestión de fichajes y ventas
class TransferManagerService {
  final Isar isar;
  final _rng = Random();

  TransferManagerService(this.isar);

  // === OFERTAS POR JUGADORES DE OTROS CLUBES ===

  /// Hacemos una oferta por un jugador de otro club
  Future<String> makeOfferForPlayer(
    Player targetPlayer,
    Team targetTeam,
    double offerAmount, {
    bool includeBuyback = false,
    double buybackAmount = 0,
    double sellOnPercentage = 0,
    List<Player> swapPlayers = const [],
  }) async {
    final finance = await isar.clubFinances.get(1);
    final save = await isar.gameSaves.get(1);
    if (finance == null || save == null) return 'Error de sistema.';

    // Verificar que podemos pagar: balance y transferBudget no son
    // independientes (el presupuesto sale de caja). No sumar ambos.
    final maxPayable = finance.balance > finance.transferBudget
        ? finance.balance
        : finance.transferBudget;
    if (offerAmount > maxPayable) {
      return 'No tienes presupuesto suficiente.';
    }

    // Verificar si es un intercambio
    final isSwap = swapPlayers.isNotEmpty;

    final offer = TransferOffer()
      ..playerId = targetPlayer.id
      ..counterpartyTeamApiId = targetTeam.apiId
      ..counterpartyTeamName = targetTeam.name
      ..offerType = isSwap ? OfferType.swap : OfferType.purchase
      ..amount = offerAmount
      ..status = OfferStatus.pending
      ..isForOurPlayer = false
      ..createdAt = DateTime.now()
      ..expiresOnMatchday = save.currentMatchday + 3
      ..buybackClause = includeBuyback ? buybackAmount : null
      ..sellOnPercentage = sellOnPercentage;

    if (isSwap) {
      offer.swapPlayerId = swapPlayers.first.id;
      offer.swapPlayerName = swapPlayers.first.name;
    }

    await isar.writeTxn(() => isar.transferOffers.put(offer));

    await MessageService(isar).add(
      title: 'Oferta enviada a ${targetTeam.name}',
      body: isSwap
          ? 'Has ofrecido intercambiar a ${swapPlayers.first.name} por ${targetPlayer.name}.'
          : 'Has ofrecido ${(offerAmount / 1e6).toStringAsFixed(2)} M€ por ${targetPlayer.name}.',
      type: MessageType.transfer,
    );

    return 'Oferta enviada correctamente.';
  }

  // === NEGOCIACIÓN ===

  /// Negocia una oferta existente (contraoferta)
  Future<String> negotiateOffer(TransferOffer offer, double newAmount) async {
    final player = await isar.players.get(offer.playerId);
    if (player == null) return 'Jugador no encontrado.';

    // Único punto donde se cuenta la ronda del usuario.
    offer.previousOffers.add(offer.amount);
    offer.amount = newAmount;
    offer.negotiationRounds++;
    offer.status = OfferStatus.negotiating;

    await isar.writeTxn(() => isar.transferOffers.put(offer));

    await MessageService(isar).add(
      title: 'Contraoferta enviada',
      body: 'Has hecho una contraoferta de ${(newAmount / 1e6).toStringAsFixed(2)} M€ por ${player.name}.',
      type: MessageType.transfer,
    );

    // Simular respuesta de la otra parte
    await _simulateNegotiationResponse(offer);

    return 'Contraoferta enviada.';
  }

  Future<void> _simulateNegotiationResponse(TransferOffer offer) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final player = await isar.players.get(offer.playerId);
    if (player == null) return;

    final acceptChance = _calculateAcceptChance(offer, player);

    if (_rng.nextDouble() < acceptChance) {
      // Aceptan la oferta
      offer.status = OfferStatus.pending;
      await MessageService(isar).add(
        title: '¡Oferta aceptada!',
        body: '${offer.counterpartyTeamName} ha aceptado tu contraoferta por ${player.name}.',
        type: MessageType.transfer,
      );
    } else if (_rng.nextDouble() < 0.7 && offer.negotiationRounds < 3) {
      // Contraoferta de ellos: misma ronda, no sumar de nuevo
      // (negotiateOffer ya contó la ronda del usuario).
      final counterAmount = offer.amount * (0.95 + _rng.nextDouble() * 0.15);
      offer.amount = counterAmount;
      offer.status = OfferStatus.negotiating;

      await MessageService(isar).add(
        title: 'Contraoferta recibida',
        body: '${offer.counterpartyTeamName} pide ${(counterAmount / 1e6).toStringAsFixed(2)} M€ por ${player.name}.',
        type: MessageType.transfer,
      );
    } else {
      // Rechazan
      offer.status = OfferStatus.rejected;
      await MessageService(isar).add(
        title: 'Oferta rechazada',
        body: '${offer.counterpartyTeamName} ha rechazado tu oferta por ${player.name}.',
        type: MessageType.transfer,
      );
    }

    await isar.writeTxn(() => isar.transferOffers.put(offer));
  }

  double _calculateAcceptChance(TransferOffer offer, Player player) {
    double baseChance = 0.3;

    // Cuanto más alta la oferta vs valor, más probabilidad
    final ratio = offer.amount / player.marketValue;
    if (ratio >= 1.3) {
      baseChance += 0.4;
    } else if (ratio >= 1.1) baseChance += 0.25;
    else if (ratio >= 0.95) baseChance += 0.1;

    // Si hay cláusulas atractivas para el vendedor
    if (offer.sellOnPercentage != null && offer.sellOnPercentage! > 0) {
      baseChance += 0.1;
    }

    // Menos probabilidad si llevamos varias rondas
    baseChance -= offer.negotiationRounds * 0.08;

    return baseChance.clamp(0.05, 0.9);
  }

  // === PRESTAMOS CON OPCIÓN A COMPRA ===

  /// Proponer un préstamo con opción a compra
  Future<String> offerLoanWithOption(
    Player player,
    Team targetTeam,
    int loanMatchdays,
    double optionAmount,
  ) async {
    final save = await isar.gameSaves.get(1);
    if (save == null) return 'Error de sistema.';

    final offer = TransferOffer()
      ..playerId = player.id
      ..counterpartyTeamApiId = targetTeam.apiId
      ..counterpartyTeamName = targetTeam.name
      ..offerType = OfferType.loanOut
      ..amount = player.salary * 0.5 * (loanMatchdays / 4)
      ..loanMatchdays = loanMatchdays
      ..status = OfferStatus.pending
      ..isForOurPlayer = true
      ..createdAt = DateTime.now()
      ..expiresOnMatchday = save.currentMatchday + 2
      ..loanWithPurchaseOption = true
      ..loanPurchaseOptionAmount = optionAmount;

    await isar.writeTxn(() => isar.transferOffers.put(offer));

    await MessageService(isar).add(
      title: 'Oferta de préstamo con opción',
      body: 'Has ofrecido a ${player.name} a ${targetTeam.name} con opción a compra por ${(optionAmount / 1e6).toStringAsFixed(2)} M€.',
      type: MessageType.transfer,
    );

    return 'Oferta enviada.';
  }

  // === LISTAS DE JUGADORES DISPONIBLES ===

  /// Obtiene jugadores de otros clubes disponibles para fichar
  Future<List<Player>> getAvailablePlayers(int userTeamApiId, {
    String? position,
    double maxPrice = double.infinity,
    int minRating = 0,
    int limit = 50,
  }) async {
    var q = isar.players
        .filter()
        .teamApiIdGreaterThan(0)
        .isYouthEqualTo(false)
        .loanedOutToTeamApiIdEqualTo(0);

    if (position != null) {
      q = q.positionEqualTo(position);
    }

    // Apply price and rating filters via where clause (Isar doesn't support these directly in filter)
    // We'll do a limited query then filter
    final candidates = await q.limit(limit * 3).findAll();

    final filtered = candidates.where((p) {
      if (p.teamApiId == userTeamApiId) return false;
      if (p.marketValue > maxPrice) return false;
      if (p.average < minRating) return false;
      return true;
    }).toList();

    filtered.sort((a, b) => b.average.compareTo(a.average));
    return filtered.take(limit).toList();
  }

  // === RECOMENDACIONES DE FICHAJE ===

  /// Obtiene recomendaciones de fichaje basadas en necesidades del equipo
  Future<List<Player>> getTransferRecommendations(int userTeamApiId) async {
    final ourSquad = await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(false)
        .findAll();

    // Contar jugadores por posición
    final positionCounts = <String, int>{};
    for (final p in ourSquad) {
      positionCounts[p.position] = (positionCounts[p.position] ?? 0) + 1;
    }

    // Identificar posiciones con menos cobertura
    final weakPositions = <String>[];
    const minimums = {'GK': 2, 'DEF': 5, 'MID': 5, 'FWD': 3};

    minimums.forEach((pos, min) {
      if ((positionCounts[pos] ?? 0) < min) {
        weakPositions.add(pos);
      }
    });

    // Buscar jugadores en esas posiciones - single query with OR
    final recommendations = <Player>[];
    final finance = await isar.clubFinances.get(1);
    final budget = finance?.transferBudget ?? 10000000;

    // Fetch all candidates for weak positions in one go
    if (weakPositions.isNotEmpty) {
      final candidates = await isar.players
          .filter()
          .teamApiIdGreaterThan(0)
          .isYouthEqualTo(false)
          .loanedOutToTeamApiIdEqualTo(0)
          .findAll();

      for (final pos in weakPositions) {
        final posCandidates = candidates
            .where((p) => p.teamApiId != userTeamApiId && p.position == pos && p.marketValue <= budget * 1.5 && p.average >= 60)
            .toList();
        posCandidates.sort((a, b) => b.average.compareTo(a.average));
        recommendations.addAll(posCandidates.take(3));
      }
    }

    // Añadir algunas joyas si hay presupuesto
    if (budget > 30000000) {
      final gems = await getAvailablePlayers(
        userTeamApiId,
        maxPrice: budget,
        minRating: 75,
        limit: 2,
      );
      recommendations.addAll(gems);
    }

    // Deduplicate by player ID
    final seen = <int>{};
    return recommendations.where((p) => seen.add(p.id)).toList();
  }

  // === INTERCAMBIOS ===

  /// Proponer un intercambio
  Future<String> proposeSwap({
    required Player ourPlayer,
    required Player targetPlayer,
    required Team targetTeam,
    double additionalCash = 0,
  }) async {
    final save = await isar.gameSaves.get(1);
    if (save == null) return 'Error de sistema.';

    final offer = TransferOffer()
      ..playerId = targetPlayer.id
      ..counterpartyTeamApiId = targetTeam.apiId
      ..counterpartyTeamName = targetTeam.name
      ..offerType = OfferType.swap
      ..amount = additionalCash
      ..status = OfferStatus.pending
      ..isForOurPlayer = false
      ..swapPlayerId = ourPlayer.id
      ..swapPlayerName = ourPlayer.name
      ..createdAt = DateTime.now()
      ..expiresOnMatchday = save.currentMatchday + 3;

    await isar.writeTxn(() => isar.transferOffers.put(offer));

    await MessageService(isar).add(
      title: 'Intercambio propuesto',
      body: 'Has ofrecido a ${ourPlayer.name} + ${(additionalCash / 1e6).toStringAsFixed(2)} M€ por ${targetPlayer.name}.',
      type: MessageType.transfer,
    );

    return 'Intercambio propuesto.';
  }
}
