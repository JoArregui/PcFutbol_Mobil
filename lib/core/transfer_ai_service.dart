import 'dart:math';
import 'package:isar/isar.dart';
import '../models/player_model.dart';
import '../models/transfer_offer.dart';
import '../models/finance_model.dart';
import '../models/game_save.dart';
import '../models/team.dart';
import '../models/game_message.dart';
import 'message_service.dart';
import 'loan_service.dart';

class TransferAiService {
  final Isar isar;
  final _rng = Random();

  TransferAiService(this.isar);

  Future<void> generateDailyMarketActivity(
    int userTeamApiId,
    int currentMatchday,
    int currentDay,
  ) async {
    // Más movimiento de mercado entre semana y menos el día de partido.
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

    squad.sort((a, b) => b.average.compareTo(a.average));
    final target = squad[_rng.nextInt(squad.length.clamp(1, 6))];
    final buyer = buyers[_rng.nextInt(buyers.length)];

    final offer = TransferOffer()
      ..playerId = target.id
      ..counterpartyTeamApiId = buyer.apiId
      ..counterpartyTeamName = buyer.name
      ..offerType = _rng.nextDouble() < 0.7 ? OfferType.purchase : OfferType.loanOut
      ..amount = target.marketValue * (0.75 + _rng.nextDouble() * 0.35)
      ..loanMatchdays = 6 + _rng.nextInt(12)
      ..status = OfferStatus.pending
      ..isForOurPlayer = true
      ..createdAt = DateTime.now()
      ..expiresOnMatchday = nextMatchday + 2;

    await isar.writeTxn(() => isar.transferOffers.put(offer));

    await MessageService(isar).add(
      title: 'Oferta de ${buyer.name}',
      body: offer.offerType == OfferType.purchase
          ? 'Quieren a ${target.name} por ${(offer.amount / 1e6).toStringAsFixed(2)} M€.'
          : 'Solicitan la cesión de ${target.name} (${offer.loanMatchdays} jornadas).',
      type: MessageType.transfer,
    );

    if (_rng.nextDouble() < 0.4) {
      await _incomingLoanOffer(userTeamApiId, teams, nextMatchday);
    }
  }

  Future<void> _incomingLoanOffer(int userTeamApiId, List<Team> teams, int md) async {
    final foreign = await isar.players
        .filter()
        .teamApiIdGreaterThan(0)
        .isYouthEqualTo(false)
        .findAll();
    final candidates =
        foreign.where((p) => p.teamApiId != userTeamApiId && p.loanedOutToTeamApiId == 0).toList();
    if (candidates.isEmpty) return;

    candidates.shuffle(_rng);
    final p = candidates.first;
    final from = teams.firstWhere((t) => t.apiId == p.teamApiId, orElse: () => teams.first);

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
      body: '${from.name} ofrece a ${p.name} cedido ${8} jornadas.',
      type: MessageType.transfer,
    );
  }

  Future<List<TransferOffer>> pendingOffers() async {
    final save = await isar.gameSaves.get(1);
    final md = save?.currentMatchday ?? 1;
    final all = await isar.transferOffers.filter().statusEqualTo(OfferStatus.pending).findAll();
    return all.where((o) => o.expiresOnMatchday >= md).toList();
  }

  Future<String> acceptOffer(TransferOffer offer, int userTeamApiId) async {
    final player = await isar.players.get(offer.playerId);
    if (player == null) return 'Jugador no encontrado.';

    if (offer.isForOurPlayer && offer.offerType == OfferType.purchase) {
      final finance = await isar.clubFinances.get(1);
      if (finance == null) return 'Error financiero.';
      finance.balance += offer.amount;
      finance.transferBudget += offer.amount * 0.5;
      finance.wageBill = (finance.wageBill - player.salary).clamp(0, double.infinity);
      await isar.writeTxn(() async {
        await isar.clubFinances.put(finance);
        await isar.players.delete(player.id);
      });
      offer.status = OfferStatus.accepted;
      await isar.writeTxn(() => isar.transferOffers.put(offer));
      return 'Venta aceptada.';
    }

    if (offer.isForOurPlayer && offer.offerType == OfferType.loanOut) {
      final to = await isar.teams.filter().apiIdEqualTo(offer.counterpartyTeamApiId).findFirst();
      if (to == null) return 'Club no encontrado.';
      await LoanService(isar).loanOutPlayer(player, to, userTeamApiId, offer.loanMatchdays);
      offer.status = OfferStatus.accepted;
      await isar.writeTxn(() => isar.transferOffers.put(offer));
      return 'Cesión salida aceptada.';
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
      return 'Cesión entrante aceptada.';
    }

    return 'Tipo de oferta no soportado.';
  }

  Future<void> rejectOffer(TransferOffer offer) async {
    offer.status = OfferStatus.rejected;
    await isar.writeTxn(() => isar.transferOffers.put(offer));
  }
}
