import 'package:isar/isar.dart';

part 'transfer_offer.g.dart';

enum OfferType { purchase, loanIn, loanOut, swap }

enum OfferStatus { pending, accepted, rejected, expired, negotiating }

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

  // === NUEVOS CAMPOS PARA FICHAJES MEJORADOS ===

  /// Para intercambios: id del jugador que nos dan a cambio
  int? swapPlayerId;
  String? swapPlayerName;

  /// Cláusula de recompra (solo para ventas)
  double? buybackClause;
  int? buybackValidYears;

  /// Porcentaje de venta futuro (solo para ventas)
  double? sellOnPercentage;

  /// Cláusula de cesión (solo para préstamos)
  bool? loanWithPurchaseOption;
  double? loanPurchaseOptionAmount;

  /// Ofertas previas (historial de negociación)
  List<double> previousOffers = [];

  /// Número de rondas de negociación
  int negotiationRounds = 0;
}
