class Sponsor {
  final String brandName;
  final double paymentPerMatch;
  final int contractDuration; // En partidos o semanas
  final String category; // Valla, Camiseta, Estadio

  Sponsor({
    required this.brandName, 
    required this.paymentPerMatch, 
    required this.contractDuration,
    required this.category,
  });
}