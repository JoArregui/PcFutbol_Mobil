import 'package:isar/isar.dart';

part 'transfer_offer.g.dart';

enum OfferType { purchase, loanIn, loanOut }

enum OfferStatus { pending, accepted, rejected, expired }

@collection
class TransferOffer {
  Id id = Isar.autoIncrement;

  late int playerId;
  late int counterpartyTeamApiId;
  late String counterpartyTeamName;

  @enumerated
  late OfferType offerType;

  late double amount;
  int loanMatchdays = 0;

  @enumerated
  late OfferStatus status;

  /// true = oferta por un jugador nuestro (venta/prestamo salida)
  bool isForOurPlayer = false;

  late DateTime createdAt;
  int expiresOnMatchday = 0;
}
