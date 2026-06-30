import 'dart:math';
import 'package:isar/isar.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';
import '../models/player_model.dart';
import '../models/transfer_offer.dart';
import '../models/team.dart';
import '../models/game_message.dart';
import 'message_service.dart';
import 'loan_service.dart';

class TransferAiService {
  final Isar isar;
  final _rng = Random();

  TransferAiService(this.isar);

  // ── Prestigio estimado del club (0‑3) ────────────────────────────────────
  int _prestige(String name) {
    final n = name.toLowerCase();
    if (n.contains('madrid') || n.contains('barcelona') || n.contains('city') ||
        n.contains('united') || n.contains('psg') || n.contains('bayern')) {
      return 3;
    }
    if (n.contains('atlético') || n.contains('atletico') || n.contains('sevilla') ||
        n.contains('liverpool') || n.contains('arsenal') || n.contains('chelsea') ||
        n.contains('juventus') || n.contains('milan') || n.contains('inter')) {
      return 2;
    }
    if (n.contains('valencia') || n.contains('betis') || n.contains('sociedad') ||
        n.contains('villarreal') || n.contains('napoli') || n.contains('roma')) {
      return 1;
    }
    return 0;
  }

  // Presupuesto estimado según prestigio (para que la IA no haga ofertas imposibles)
  double _estimatedBudget(int prestige) {
    switch (prestige) {
      case 3:
        return 120000000;
      case 2:
        return 50000000;
      case 1:
        return 25000000;
      default:
        return 10000000;
    }
  }

  // ── Multiplicador de oferta según personalidad del jugador ───────────────
  // Un jugador loyal acepta menos de un club que ya conoce; greedy exige más
  double _personalityOfferMultiplier(Player p, int buyerPrestige) {
    switch (p.personality) {
      case Personality.greedy:
        // Greedy siempre quiere el máximo, sin importar quién compra
        return 1.25;
      case Personality.ambitious:
        // Ambitious acepta algo menos si el comprador es un club grande
        return buyerPrestige >= 2 ? 0.95 : 1.10;
      case Personality.loyal:
        // Loyal es más difícil de comprar: pide más para justificar el cambio
        return 1.15;
      case Personality.professional:
        return 1.00;
    }
  }

  // ── Probabilidad de que un jugador loyal rechace un rival ────────────────
  bool _loyalPlayerRefuses(Player p, int sellerTeamApiId, int buyerTeamApiId) {
    if (p.personality != Personality.loyal) return false;
    // Los jugadores loyales tienen un 60% de rechazar ir a un rival directo
    // (simplificado: si ambos están en la misma liga / tienen ids cercanos)
    final isRival = (sellerTeamApiId - buyerTeamApiId).abs() < 5;
    return isRival && _rng.nextDouble() < 0.60;
  }

  // ── Actividad diaria de mercado ──────────────────────────────────────────

  Future<void> generateDailyMarketActivity(
    int userTeamApiId,
    int currentMatchday,
    int currentDay,
  ) async {
    final chance = currentDay == 7 ? 0.18 : 0.38;
    if (_rng.nextDouble() > chance) return;
    await generateMatchdayOffers(userTeamApiId, currentMatchday);
  }

  Future<void> generateMatchdayOffers(int userTeamApiId, int nextMatchday) async {
    final save = await isar.gameSaves.get(1);
    if (save == null || save.seasonFinished) return;

    final squad = await isar.players
        .filter()
        .teamApiIdEqualTo(userTeamApiId)
        .isYouthEqualTo(false)
        .findAll();
    if (squad.length < 17) return;

    final teams = await isar.teams.where().findAll();
    final buyers = teams.where((t) => t.apiId != userTeamApiId).toList();
    if (buyers.isEmpty) return;

    // Elegir objetivo: más peso en jugadores mediocres/titulares alternos
    squad.sort((a, b) => b.average.compareTo(a.average));
    final poolSize = squad.length.clamp(1, 10);
    final target = squad[_rng.nextInt(poolSize)];
    final buyer = buyers[_rng.nextInt(buyers.length)];

    final buyerPrestige = _prestige(buyer.name);
    final buyerBudget = _estimatedBudget(buyerPrestige);

    // El jugador loyal puede negarse a ir a ciertos clubes
    if (_loyalPlayerRefuses(target, userTeamApiId, buyer.apiId)) return;

    // La IA no hace ofertas que no puede pagar
    final minOfferForPlayer =
        target.marketValue * _personalityOfferMultiplier(target, buyerPrestige) * 0.70;
    if (minOfferForPlayer > buyerBudget) return;

    // Calcular oferta real: entre 75% y 110% del valor ajustado por personalidad
    final adjustedValue =
        target.marketValue * _personalityOfferMultiplier(target, buyerPrestige);
    final offerAmount =
        adjustedValue * (0.75 + _rng.nextDouble() * 0.35);

    final isLoan = _rng.nextDouble() < 0.35 ||
        offerAmount > buyerBudget; // si no puede comprar, propone cesión

    final offer = TransferOffer()
      ..playerId = target.id
      ..counterpartyTeamApiId = buyer.apiId
      ..counterpartyTeamName = buyer.name
      ..offerType = isLoan ? OfferType.loanOut : OfferType.purchase
      ..amount = isLoan ? target.salary * 0.5 * 6 : offerAmount
      ..loanMatchdays = 6 + _rng.nextInt(12)
      ..status = OfferStatus.pending
      ..isForOurPlayer = true
      ..createdAt = DateTime.now()
      ..expiresOnMatchday = nextMatchday + 2;

    await isar.writeTxn(() => isar.transferOffers.put(offer));

    // Mensaje con contexto de personalidad
    final personalityHint = _personalityHint(target);
    await MessageService(isar).add(
      title: 'Oferta de ${buyer.name}',
      body: isLoan
          ? 'Quieren ceder a ${target.name} (${offer.loanMatchdays} jornadas). $personalityHint'
          : 'Ofrecen ${(offer.amount / 1e6).toStringAsFixed(2)} M€ por ${target.name}. $personalityHint',
      type: MessageType.transfer,
    );

    // Con un 35% de prob, también generamos oferta de cesión entrante
    if (_rng.nextDouble() < 0.35) {
      await _incomingLoanOffer(userTeamApiId, teams, nextMatchday);
    }
  }

  String _personalityHint(Player p) {
    switch (p.personality) {
      case Personality.greedy:
        return "Es ambicioso: querrá buenas condiciones.";
      case Personality.ambitious:
        return "Busca un gran proyecto deportivo.";
      case Personality.loyal:
        return "Es leal: puede resistirse al traspaso.";
      case Personality.professional:
        return "Decidirá según el proyecto.";
    }
  }

  Future<void> _incomingLoanOffer(
      int userTeamApiId, List<Team> teams, int md) async {
    final foreign = await isar.players
        .filter()
        .teamApiIdGreaterThan(0)
        .isYouthEqualTo(false)
        .findAll();
    final candidates = foreign
        .where((p) =>
            p.teamApiId != userTeamApiId && p.loanedOutToTeamApiId == 0)
        .toList();
    if (candidates.isEmpty) return;

    candidates.shuffle(_rng);
    final p = candidates.first;
    final from = teams.firstWhere(
      (t) => t.apiId == p.teamApiId,
      orElse: () => teams.first,
    );

    // Los clubes de élite no ceden sus mejores jugadores a clubes modestos
    final userPrestige = _prestige(
        teams.firstWhere((t) => t.apiId == userTeamApiId,
                orElse: () => teams.first)
            .name);
    final senderPrestige = _prestige(from.name);
    if (senderPrestige - userPrestige > 1 && _rng.nextDouble() < 0.65) return;

    await isar.writeTxn(() => isar.transferOffers.put(TransferOffer()
      ..playerId = p.id
      ..counterpartyTeamApiId = from.apiId
      ..counterpartyTeamName = from.name
      ..offerType = OfferType.loanIn
      ..amount = p.salary * 0.5
      ..loanMatchdays = 8
      ..status = OfferStatus.pending
      ..isForOurPlayer = false
      ..createdAt = DateTime.now()
      ..expiresOnMatchday = md + 2));

    await MessageService(isar).add(
      title: 'Cesión disponible',
      body: '${from.name} ofrece a ${p.name} cedido 8 jornadas. ${_personalityHint(p)}',
      type: MessageType.transfer,
    );
  }

  // ── Consultas ────────────────────────────────────────────────────────────

  Future<List<TransferOffer>> pendingOffers() async {
    final save = await isar.gameSaves.get(1);
    final md = save?.currentMatchday ?? 1;
    final all = await isar.transferOffers
        .filter()
        .statusEqualTo(OfferStatus.pending)
        .findAll();
    return all.where((o) => o.expiresOnMatchday >= md).toList();
  }

  // ── Aceptar / rechazar ───────────────────────────────────────────────────

  Future<String> acceptOffer(TransferOffer offer, int userTeamApiId) async {
    final player = await isar.players.get(offer.playerId);
    if (player == null) return 'Jugador no encontrado.';

    if (offer.isForOurPlayer && offer.offerType == OfferType.purchase) {
      final finance = await isar.clubFinances.get(1);
      if (finance == null) return 'Error financiero.';
      finance.balance += offer.amount;
      finance.transferBudget += offer.amount * 0.5;
      finance.wageBill =
          (finance.wageBill - player.salary).clamp(0, double.infinity);
      await isar.writeTxn(() async {
        await isar.clubFinances.put(finance);
        await isar.players.delete(player.id);
      });
      offer.status = OfferStatus.accepted;
      await isar.writeTxn(() => isar.transferOffers.put(offer));
      return 'Venta aceptada. +${(offer.amount / 1e6).toStringAsFixed(2)} M€ ingresados.';
    }

    if (offer.isForOurPlayer && offer.offerType == OfferType.loanOut) {
      final to = await isar.teams
          .filter()
          .apiIdEqualTo(offer.counterpartyTeamApiId)
          .findFirst();
      if (to == null) return 'Club no encontrado.';
      await LoanService(isar)
          .loanOutPlayer(player, to, userTeamApiId, offer.loanMatchdays);
      offer.status = OfferStatus.accepted;
      await isar.writeTxn(() => isar.transferOffers.put(offer));
      return 'Cesión salida aceptada (${offer.loanMatchdays} jornadas).';
    }

    if (!offer.isForOurPlayer && offer.offerType == OfferType.loanIn) {
      await LoanService(isar).loanInPlayer(
        player,
        offer.counterpartyTeamApiId,
        userTeamApiId,
        offer.loanMatchdays,
      );
      offer.status = OfferStatus.accepted;
      await isar.writeTxn(() => isar.transferOffers.put(offer));
      return 'Cesión entrante aceptada (${offer.loanMatchdays} jornadas).';
    }

    return 'Tipo de oferta no soportado.';
  }

  Future<void> rejectOffer(TransferOffer offer) async {
    offer.status = OfferStatus.rejected;
    await isar.writeTxn(() => isar.transferOffers.put(offer));
  }
}