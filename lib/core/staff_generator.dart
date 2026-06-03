import 'dart:math';
import '../models/staff_member.dart';

/// Genera candidatos aleatorios para secretario, preparador y médico.
class StaffGenerator {
  static final _rng = Random();

  static const _firstNames = [
    'Adolfo', 'Agustín', 'Alberto', 'Alfonso', 'Andrés', 'Antonio', 'Arturo', 'Benito',
    'Bernardo', 'Carlos', 'César', 'Claudio', 'Clemente', 'Daniel', 'David', 'Domingo',
    'Eduardo', 'Emilio', 'Enrique', 'Ernesto', 'Esteban', 'Federico', 'Felipe', 'Fernando',
    'Francisco', 'Gabriel', 'Gaspar', 'Gonzalo', 'Gregorio', 'Guillermo', 'Héctor', 'Hugo',
    'Ignacio', 'Isidro', 'Iván', 'Jaime', 'Javier', 'Joaquín', 'Jorge', 'José', 'Juan',
    'Julio', 'Leandro', 'Lorenzo', 'Luis', 'Manuel', 'Marcos', 'Mario', 'Martín', 'Miguel',
    'Nicolás', 'Octavio', 'Pablo', 'Patricio', 'Pedro', 'Rafael', 'Ramiro', 'Ramón',
    'Raúl', 'Ricardo', 'Roberto', 'Rodrigo', 'Rubén', 'Salvador', 'Santiago', 'Sergio',
    'Tomás', 'Vicente', 'Víctor', 'Xavier',
  ];

  static const _lastNames = [
    'Alonso', 'Álvarez', 'Amador', 'Blanco', 'Bravo', 'Cabrera', 'Calvo', 'Campos',
    'Cano', 'Castro', 'Cortés', 'Delgado', 'Díaz', 'Domínguez', 'Durán', 'Escudero',
    'Esteban', 'Ferrer', 'Flores', 'Fuentes', 'Gallardo', 'García', 'Gil', 'Gómez',
    'González', 'Guerrero', 'Gutiérrez', 'Hernández', 'Herrera', 'Iglesias', 'Jiménez',
    'León', 'López', 'Lozano', 'Marín', 'Márquez', 'Martín', 'Martínez', 'Medina',
    'Méndez', 'Molina', 'Montero', 'Morales', 'Moreno', 'Muñoz', 'Navarro', 'Nieto',
    'Núñez', 'Ortega', 'Ortiz', 'Pascual', 'Pastor', 'Pérez', 'Prieto', 'Ramírez',
    'Ramos', 'Reyes', 'Rivera', 'Robles', 'Rodríguez', 'Romero', 'Rubio', 'Ruiz',
    'Sáez', 'Sánchez', 'Santana', 'Santiago', 'Serrano', 'Soto', 'Suárez', 'Torres',
    'Vargas', 'Vázquez', 'Vega', 'Velasco', 'Vicente', 'Vidal', 'Villa', 'Zamora',
  ];

  /// [count] candidatos distintos por rol (por defecto 8).
  static List<StaffMember> generateCandidates(StaffRole role, {int count = 8}) {
    final usedNames = <String>{};
    final list = <StaffMember>[];
    var attempts = 0;

    while (list.length < count && attempts < count * 20) {
      attempts++;
      final member = _oneCandidate(role);
      if (usedNames.add(member.name)) {
        list.add(member);
      }
    }

    list.sort((a, b) => a.salary.compareTo(b.salary));
    return list;
  }

  static StaffMember _oneCandidate(StaffRole role) {
    final level = _weightedLevel();
    final name = _randomName(role);
    return StaffMember(
      name: name,
      role: role,
      level: level,
      salary: _salaryForLevel(level),
      description: _description(role, level),
    );
  }

  static int _weightedLevel() {
    final roll = _rng.nextDouble();
    if (roll < 0.22) return 1;
    if (roll < 0.45) return 2;
    if (roll < 0.68) return 3;
    if (roll < 0.88) return 4;
    return 5;
  }

  static double _salaryForLevel(int level) {
    const base = 8500.0;
    return (base * level * (1.0 + level * 0.35)).roundToDouble();
  }

  static String _randomName(StaffRole role) {
    final first = _firstNames[_rng.nextInt(_firstNames.length)];
    final last = _lastNames[_rng.nextInt(_lastNames.length)];

    // Eliminados los apodos con comillas por completo.
    if (_rng.nextDouble() < 0.15) {
      return '$first ${_lastNames[_rng.nextInt(_lastNames.length)]}-$last';
    }
    return '$first $last';
  }

  static String _description(StaffRole role, int level) {
    final pool = switch (role) {
      StaffRole.secretario => _secretarioDesc(level),
      StaffRole.preparador => _preparadorDesc(level),
      StaffRole.medico => _medicoDesc(level),
      _ => ['Profesional contrastado.'],
    };
    return pool[_rng.nextInt(pool.length)];
  }

  static List<String> _secretarioDesc(int level) {
    if (level <= 2) {
      return [
        'Recién salido de la escuela de mánagers. Organizado pero inexperto.',
        'Domina el fax y la plantilla en Excel. Aún aprende el mercado.',
        'Le gusta hablar con periodistas. A veces demasiado.',
        'Fichó a un amigo del pueblo la pretemporada pasada.',
      ];
    }
    if (level <= 4) {
      return [
        'Negocia cláusulas como pocos. Conoce a medio agente de LaLiga.',
        'Lleva el calendario al minuto. El presidente confía en sus informes.',
        'Veterano de despachos de Segunda. Sabe cuándo vender.',
        'Arregla lesiones administrativas antes de que existan.',
      ];
    }
    return [
      'Leyenda de los despachos. Le llaman los clubes grandes.',
      'Cerró traspasos imposibles en tres mercados seguidos.',
      'Su agenda vale oro. El consejo lo escucha siempre.',
      'Ex secretario de selección. Habla seis idiomas en negociaciones.',
    ];
  }

  static List<String> _preparadorDesc(int level) {
    if (level <= 2) {
      return [
        'Sesiones de gimnasio clásicas. Mucho estiramiento, poco GPS.',
        'Viene del fútbol sala. Intenso en la pretemporada.',
        'Cree en las sentadillas por encima de todo.',
        'Todavía busca su método. Los veteranos se quejan poco.',
      ];
    }
    if (level <= 4) {
      return [
        'Planifica cargas con datos. Menos lesiones musculares.',
        'Trabajó en clubes europeos. Recuperación en 48 horas.',
        'Sus rutinas de velocidad asustan a los extremos.',
        'El vestuario respeta su pitido en los entrenos.',
      ];
    }
    return [
      'Preparador físico de élite. Referencia en LaLiga.',
      'Sus equipos corren más en el minuto 90 que en el 1.',
      'Ha rejuvenecido plantillas de más de 30 años.',
      'Publicó papers sobre prevención de roturas. Top mundial.',
    ];
  }

  static List<String> _medicoDesc(int level) {
    if (level <= 2) {
      return [
        'Tape y hielo. Solución rápida para todo.',
        'Estudiante de medicina del deporte en prácticas.',
        'Optimista: «estará para el domingo» casi siempre.',
        'Botiquín básico pero manos rápidas en el campo.',
      ];
    }
    if (level <= 4) {
      return [
        'Especialista en isquiotibiales. Diagnósticos serios.',
        'Rechaza partidos arriesgados. El míster a veces discute.',
        'Trajo fisioterapeutas de su confianza al club.',
        'Reduce bajas a la mitad respecto a la temporada anterior.',
      ];
    }
    return [
      'Jefe de servicios médicos de selección. Oro puro.',
      'Recupera estrellas en la mitad de tiempo estimado.',
      'Los agentes le consultan antes de firmar.',
      'Su nombre asusta a las entradas duras rivales.',
    ];
  }
}