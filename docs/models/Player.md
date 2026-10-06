# Modelo: Player (Jugador)
Entidad Isar que representa a un jugador de fútbol en el juego.

## Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `id` | `Id` | ID autoincremental de Isar |
| `name` | `String` | Nombre completo del jugador |
| `teamId` | `String` | ID del equipo al que pertenece |
| `teamApiId` | `int?` | ID del equipo en API-Football |
| `age` | `int` | Edad del jugador |
| `position` | `String` | Posición del campo (ej: 'POR', 'DEF', 'MED', 'DEL') |
| `stats` | `List<int>` | Array con 5 stats: [Velocidad, Tiro, Pase, Defensa, Físico] |
| `marketValue` | `double` | Valor de mercado en millones de euros |
| `salary` | `double` | Salario anual del jugador |
| `buyoutClause` | `double` | Cláusula de rescisión |
| `personality` | `Personality` | Personalidad para negociaciones |
| `injuredDays` | `int` | Días de lesión restantes (0 = apto) |
| `suspendedMatches` | `int` | Partidos de sanción pendientes |
| `isYouth` | `bool` | Jugador de cantera |
| `contractYearsRemaining` | `int` | Años restantes de contrato |
| `nationality` | `String` | Nacionalidad (código ISO 3166-1 alpha-3) |
| `onLoanFromTeamApiId` | `int` | Equipo que nos cede al jugador (0 = no) |
| `onLoanUntilMatchday` | `int` | Jornada hasta la que está cedido a nosotros |
| `loanedOutToTeamApiId` | `int` | Equipo al que hemos cedido al jugador (0 = no) |
| `loanedOutUntilMatchday` | `int` | Jornada hasta la que está cedido fuera |
| `isGenerated` | `bool` | Jugador generado localmente (no de API) |
| `isUnicorn` | `bool` | Canterano con potencial excepcional |
| `potential` | `int` | Techo máximo de atributos (1-99) |

## Métodos

### `double get average`
Calcula la media global del jugador a partir de sus 5 stats.
```dart
double get average {
  if (stats.isEmpty) return 0.0;
  final total = stats.reduce((a, b) => a + b);
  return total / stats.length;
}
```

## Enumeraciones

### `Personality`
Personalidades disponibles para los jugadores:
- `ambitious`: Ambicioso
- `loyal`: Leal
- `greedy`: Codicioso
- `professional`: Profesional
