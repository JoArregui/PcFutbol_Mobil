/// Bonificaciones de formación (referencia PC Fútbol 7).
class TacticsService {
  static const formations = ['4-4-2', '4-3-3', '3-5-2', '5-3-2'];

  /// Multiplicador de ataque (goles) y defensa para el motor de partido.
  static ({double attack, double defense}) modifiers(String formation) {
    switch (formation) {
      case '4-3-3':
        return (attack: 1.12, defense: 0.94);
      case '3-5-2':
        return (attack: 1.05, defense: 1.02);
      case '5-3-2':
        return (attack: 0.88, defense: 1.14);
      case '4-4-2':
      default:
        return (attack: 1.0, defense: 1.0);
    }
  }

  static String label(String formation) {
    switch (formation) {
      case '4-3-3':
        return 'Ofensiva — más llegada al área';
      case '3-5-2':
        return 'Equilibrada — control del medio';
      case '5-3-2':
        return 'Defensiva — muro en atrás';
      default:
        return 'Clásica — equilibrio total';
    }
  }
}
