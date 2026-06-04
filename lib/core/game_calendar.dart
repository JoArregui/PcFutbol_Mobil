/// Fechas de calendario reales para la temporada (Liga española, semanas lun–dom).
class GameCalendar {
  GameCalendar._();

  static const _weekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  static const _monthsShort = [
    'ene', 'feb', 'mar', 'abr', 'may', 'jun',
    'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
  ];

  static const _monthsFull = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];

  /// Lunes de la semana previa al inicio de liga (temporada 1 ≈ ago 2025).
  static DateTime seasonStartMonday(int seasonNumber) {
    return DateTime(2024 + seasonNumber, 8, 11);
  }

  static DateTime dateFor({
    required int seasonNumber,
    required int matchday,
    required int dayOfWeek,
  }) {
    final start = seasonStartMonday(seasonNumber);
    final offset = (matchday - 1) * 7 + (dayOfWeek - 1);
    return start.add(Duration(days: offset));
  }

  static String weekdayName(DateTime date) => _weekdays[date.weekday - 1];

  static String monthShort(DateTime date) => _monthsShort[date.month - 1];

  static String monthFull(DateTime date) => _monthsFull[date.month - 1];

  /// Chip del menú: "12 ago · Mar"
  static String formatHeader({
    required int seasonNumber,
    required int matchday,
    required int dayOfWeek,
  }) {
    final d = dateFor(
      seasonNumber: seasonNumber,
      matchday: matchday,
      dayOfWeek: dayOfWeek,
    );
    return '${d.day} ${monthShort(d)} · ${weekdayName(d).substring(0, 3)}';
  }

  /// Animación al pasar día (fecha a la que avanzamos).
  static String formatAdvanceOverlay({
    required int seasonNumber,
    required int matchday,
    required int dayOfWeek,
  }) {
    final d = dateFor(
      seasonNumber: seasonNumber,
      matchday: matchday,
      dayOfWeek: dayOfWeek,
    );
    return '${d.day} ${monthFull(d).toUpperCase()} ${d.year}\n${weekdayName(d).toUpperCase()} · Jornada $matchday';
  }

  /// Fecha del partido (domingo de la jornada).
  static String formatMatchdaySunday({
    required int seasonNumber,
    required int matchday,
  }) {
    final d = dateFor(seasonNumber: seasonNumber, matchday: matchday, dayOfWeek: 7);
    return 'Dom ${d.day} ${monthShort(d)}';
  }

  static String formatShort({
    required int seasonNumber,
    required int matchday,
    required int dayOfWeek,
  }) {
    final d = dateFor(
      seasonNumber: seasonNumber,
      matchday: matchday,
      dayOfWeek: dayOfWeek,
    );
    return '${weekdayName(d)}, ${d.day} de ${monthFull(d)}';
  }

  /// Calcula el día de juego tras pulsar «Pasar día».
  static ({int matchday, int dayOfWeek}) nextAfterAdvance({
    required int matchday,
    required int dayOfWeek,
  }) {
    var day = dayOfWeek + 1;
    var md = matchday;
    if (day > 7) day = 1;
    return (matchday: md, dayOfWeek: day);
  }

  static String seasonLabel(int seasonNumber) =>
      '${2024 + seasonNumber}/${(2024 + seasonNumber + 1) % 100}';
}
