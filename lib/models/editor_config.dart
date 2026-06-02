import 'package:isar/isar.dart';

part 'editor_config.g.dart';

/// Configuración editable (nombre de liga, etc.) estilo editor PC Fútbol.
@collection
class EditorConfig {
  Id id = 1;

  String leagueName = 'LaLiga EA Sports';
  String seasonLabel = '2025/26';

  /// Si no está vacío, sustituye el nombre del club del usuario en la UI
  String userTeamNameOverride = '';
}
