# Modelo: Team (Equipo)
Entidad Isar que representa a un equipo de La Liga.

## Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `id` | `Id` | ID autoincremental |
| `apiId` | `int` | ID único de API-Football |
| `name` | `String` | Nombre del equipo |
| `city` | `String` | Ciudad |
| `stadium` | `String` | Nombre del estadio |
| `stadiumCapacity` | `int` | Capacidad del estadio |
| `logoUrl` | `String` | URL del escudo |
| `budget` | `int` | Presupuesto total |
| `previousSeasonPosition` | `int` | Posición de la temporada anterior |
| `squadAverageRating` | `double` | Media de la plantilla |
| `initialRealPlayersCount` | `int` | Contador de jugadores reales iniciales |
| `initialGeneratedPlayersCount` | `int` | Contador de jugadores generados iniciales |

## Métodos y Getters

### `TeamTier getTierForTeam(String teamName)`
Categoriza al equipo en un tier según su nivel.

**Tiers disponibles**:
- `TeamTier.elite`: Real Madrid, Barcelona
- `TeamTier.top`: Atlético, Real Sociedad, Sevilla, Betis, Villarreal
- `TeamTier.upperMid`: Valencia, Athletic, Celta, Osasuna
- `TeamTier.midTable`: Getafe, Rayo, Girona, Espanyol
- `TeamTier.lowerMid`: Almería, Granada, Cádiz
- `TeamTier.relegation`: Equipos recién ascendidos o con presupuesto limitado

### `int _getPreviousSeasonPosition(String teamName)`
Devuelve la posición de la temporada anterior (basada en 2023-2024).

### `int calculateAdjustedBudget(int baseBudget, int previousPosition, double squadAverage)`
Calcula el presupuesto ajustado por posición y media de plantilla.

### `int getBaseBudgetForTier(TeamTier tier, String teamName)`
Devuelve el presupuesto base según el tier.

### `String get formattedBudget`
Devuelve el presupuesto formateado con puntos (ej: "150.000.000 €").

### `Map<String, String> get expectations`
Devuelve las expectativas de la directiva y la exigencia según el tier.

## Método de Constructor

### `Team.fromJson(Map<String, dynamic> json)`
Crea una instancia de Team desde un JSON de API-Football.
