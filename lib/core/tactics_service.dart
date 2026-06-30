/// Bonificaciones de formación y estilo (referencia PC Fútbol 7).
enum TeamMentality {
  veryDefensive,
  defensive,
  balanced,
  attacking,
  veryAttacking
}

enum TeamIntensity {
  low,
  normal,
  high,
  veryHigh
}

enum TeamStyle {
  possession,
  direct,
  counterAttack,
  longBall
}

class TacticsService {
  static const formations = ['4-4-2', '4-3-3', '3-5-2', '5-3-2', '4-2-3-1', '4-5-1'];

  /// Obtiene la etiqueta de una formación
  static String formationLabel(String formation) {
    switch (formation) {
      case '4-3-3':
        return 'Ofensiva — más llegada al área';
      case '3-5-2':
        return 'Equilibrada — control del medio';
      case '5-3-2':
        return 'Defensiva — muro en atrás';
      case '4-2-3-1':
        return 'Control — medio sólido + punta';
      case '4-5-1':
        return 'Ultra-defensiva — 1 punta solo';
      case '4-4-2':
      default:
        return 'Clásica — equilibrio total';
    }
  }

  /// Obtiene la etiqueta de la mentalidad
  static String mentalityLabel(TeamMentality mentality) {
    switch (mentality) {
      case TeamMentality.veryDefensive:
        return 'Ultra-defensiva — cerrar shop';
      case TeamMentality.defensive:
        return 'Defensiva — priorizar no encajar';
      case TeamMentality.balanced:
        return 'Equilibrada — peso igual en ambos';
      case TeamMentality.attacking:
        return 'Ofensiva — ir a por el partido';
      case TeamMentality.veryAttacking:
        return 'Todo al ataque — riesgo alto';
    }
  }

  /// Obtiene la etiqueta de la intensidad
  static String intensityLabel(TeamIntensity intensity) {
    switch (intensity) {
      case TeamIntensity.low:
        return 'Baja — conservar energía';
      case TeamIntensity.normal:
        return 'Normal — ritmo clásico';
      case TeamIntensity.high:
        return 'Alta — presionar mucho';
      case TeamIntensity.veryHigh:
        return 'Muy alta — presión total';
    }
  }

  /// Obtiene la etiqueta del estilo
  static String styleLabel(TeamStyle style) {
    switch (style) {
      case TeamStyle.possession:
        return 'Toque — mantener el balón';
      case TeamStyle.direct:
        return 'Directo — buscar rápido al delantero';
      case TeamStyle.counterAttack:
        return 'Contraataque — aprovechar espacios';
      case TeamStyle.longBall:
        return 'Balón largo — al área directamente';
    }
  }

  /// Multiplicadores completos de táctica para el motor de partido
  static ({double attack, double defense, double possession, double energy}) fullModifiers({
    required String formation,
    required TeamMentality mentality,
    required TeamIntensity intensity,
    required TeamStyle style,
  }) {
    // Base por formación
    final base = _formationModifiers(formation);

    // Ajustes por mentalidad
    var attack = base.attack;
    var defense = base.defense;

    switch (mentality) {
      case TeamMentality.veryDefensive:
        attack *= 0.75;
        defense *= 1.25;
        break;
      case TeamMentality.defensive:
        attack *= 0.9;
        defense *= 1.1;
        break;
      case TeamMentality.balanced:
        // Sin cambios
        break;
      case TeamMentality.attacking:
        attack *= 1.1;
        defense *= 0.9;
        break;
      case TeamMentality.veryAttacking:
        attack *= 1.25;
        defense *= 0.75;
        break;
    }

    // Ajustes por intensidad (afecta energía)
    var energy = 1.0;
    switch (intensity) {
      case TeamIntensity.low:
        energy = 0.7;
        attack *= 0.95;
        break;
      case TeamIntensity.normal:
        energy = 1.0;
        break;
      case TeamIntensity.high:
        energy = 1.3;
        attack *= 1.05;
        break;
      case TeamIntensity.veryHigh:
        energy = 1.6;
        attack *= 1.1;
        defense *= 0.95;
        break;
    }

    // Ajustes por estilo
    var possession = 0.5;
    switch (style) {
      case TeamStyle.possession:
        possession = 0.6;
        attack *= 1.02;
        break;
      case TeamStyle.direct:
        possession = 0.48;
        attack *= 1.03;
        break;
      case TeamStyle.counterAttack:
        possession = 0.42;
        attack *= 1.05;
        defense *= 1.03;
        break;
      case TeamStyle.longBall:
        possession = 0.4;
        attack *= 1.02;
        break;
    }

    return (
      attack: attack,
      defense: defense,
      possession: possession,
      energy: energy,
    );
  }

  /// Multiplicador base por formación
  static ({double attack, double defense}) _formationModifiers(String formation) {
    switch (formation) {
      case '4-3-3':
        return (attack: 1.12, defense: 0.94);
      case '3-5-2':
        return (attack: 1.05, defense: 1.02);
      case '5-3-2':
        return (attack: 0.88, defense: 1.14);
      case '4-2-3-1':
        return (attack: 1.03, defense: 1.03);
      case '4-5-1':
        return (attack: 0.85, defense: 1.18);
      case '4-4-2':
      default:
        return (attack: 1.0, defense: 1.0);
    }
  }

  /// Método legacy para compatibilidad
  static ({double attack, double defense}) modifiers(String formation) {
    return _formationModifiers(formation);
  }

  /// Método legacy para compatibilidad
  static String label(String formation) => formationLabel(formation);
}
