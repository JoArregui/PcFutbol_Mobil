# Servicio: SquadService (Gestión de Plantillas)
Garantiza que cada equipo tenga una plantilla válida, siguiendo la regla 70/30 (70% reales, 30% generados) **solamente en la configuración inicial**.

## Constantes

| Constante | Valor | Descripción |
|-----------|-------|-------------|
| `minSquadSize` | 20 | Tamaño mínimo de plantilla |
| `preferredSquadSize` | 24 | Tamaño ideal de plantilla |
| `minRealRatio` | 0.70 | Porcentaje mínimo de jugadores reales |
| `maxGeneratedRatio` | 0.30 | Porcentaje máximo de jugadores generados |

## Métodos Principales

### `SquadService(this.isar)`
Constructor básico que recibe la instancia de Isar.

### `SquadService.fromDatabase(DatabaseService db)`
Constructor alternativo que recibe un DatabaseService.

### `Future<bool> _isInitialSetup()`
Devuelve `true` si no hay una partida activa (GameSave).
```dart
Future<bool> _isInitialSetup() async {
  final save = await isar.gameSaves.get(1);
  return save == null;
}
```

### `Future<List<Player>> ensureSquad(int teamApiId, {bool tryApiFirst = true})`
Asegura que el equipo tenga una plantilla válida. Si es la configuración inicial, aplica la regla 70/30.

**Parámetros**:
- `teamApiId`: ID del equipo en la API
- `tryApiFirst`: Intentar descargar desde API-Football primero

### `Future<List<Player>> _enforce7030Rule(int teamApiId, List<Player> players, int season)`
Aplica rigurosamente la regla de 70% reales y 30% generados en la configuración inicial.

**Flujo**:
1. Calcular el mínimo de reales necesarios
2. Eliminar generados de más
3. Añadir más reales si es necesario
4. Completar con generados hasta el tamaño preferido
5. Aplicar requisitos posicionales

### `Future<void> _updateTeamStats(int teamApiId, List<Player> players)`
Actualiza:
- Media de la plantilla
- Presupuesto ajustado
- Contadores de jugadores reales/generados

### `Future<List<Player>> _applyPositionalRequirements(...)`
Asegura que haya suficientes jugadores por posición:
- GK: 2
- DEF: 5
- MID: 5
- FWD: 5

### `Future<void> _addPlayers(List<Player> players)`
Añade jugadores nuevos a la base de datos sin duplicar los existentes.

### `Future<void> ensureAllTeams()`
Aplica `ensureSquad` a todos los equipos del juego.
