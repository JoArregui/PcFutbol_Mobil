# PC Fútbol 2026 — Documentación Técnica y de Usuario

> **Homenaje al simulador de gestión PC Fútbol 7**, desarrollado en Flutter/Dart. Réplica moderna de la jugabilidad clásica del clásico español, con persistencia local (Isar), sincronización inicial con API-Football, motor de partido propio, calendario unificado liga/copa, sistema financiero, cuerpo técnico, prensa, directiva y progresión de jugadores entre temporadas.

---

## Índice

1. [Introducción y visión general](#1-introducción-y-visión-general)
2. [Tecnologías y stack](#2-tecnologías-y-stack)
3. [Requisitos y configuración](#3-requisitos-y-configuración)
4. [Arquitectura del proyecto](#4-arquitectura-del-proyecto)
5. [Capa de modelos (Isar)](#5-capa-de-modelos-isar)
6. [Capa de servicios (core/)](#6-capa-de-servicios-core)
7. [Capa de pantallas (screens/)](#7-capa-de-pantallas-screens)
8. [Capa de widgets (widgets/)](#8-capa-de-widgets-widgets)
9. [Cómo jugar (gameplay)](#9-cómo-jugar-gameplay)
10. [Flujo de datos](#10-flujo-de-datos)
11. [Generación de código](#11-generación-de-código)
12. [Notas y consideraciones](#12-notas-y-consideraciones)
13. [Estructura detallada del proyecto](#13-estructura-detallada-del-proyecto)

---

## 1. Introducción y visión general

**PC Fútbol 2026** es un simulador de gestión futbolística *single-player* cuyo objetivo es recuperar la experiencia del clásico *PC Fútbol 7* (Dinamic Multimedia, 1997) en dispositivos modernos. El jugador asume el rol de **entrenador/manager** de un club de LaLiga EA Sports y debe compaginar cuatro ejes:

- **Deportivo**: plantilla, alineación, táctica, entrenamiento, partido en modo resumen o resultado, liga de 38 jornadas y Copa del Rey con eliminatorias.
- **Económico**: caja, presupuesto de fichajes, masa salarial, precio de entradas, patrocinadores, mantenimiento del estadio, ampliación de grada y crédito bancario.
- **Directiva**: objetivos de la presidencia, confianza, requerimientos (canteranos, porterías a cero, fichajes estrella…), encuestas a la afición, despido por bajo rendimiento o por quiebra técnica.
- **Mercado**: fichajes, ventas, cesiones (con/sin opción de compra), intercambios, ofertas con contraofertas, cláusula de recompra, % de venta futura y scouting internacional.

### Objetivos

- **Modernizar** el flujo 2D de menús y partidos de PCF7 con animaciones suaves, tipografía Urbanist y modo oscuro estilo "despacho de noche".
- **Mantener la accesibilidad** del original: gestión por tarjetas (Plantilla, Alineación, Tácticas, Entreno, Mercado, Ofertas, Ojeador, Editor, Finanzas, Estadio, Staff, Calendario, Club, Presidente, Clasificación, Mensajes).
- **Acoplar datos reales** mediante *API-Football* (synchronización única la primera vez) y mantener el resto de la partida 100 % offline sobre Isar.
- **Carrera larga**: temporadas encadenadas automáticamente, progresión, retiradas y rejuvenecimiento de plantilla.

### Alcance

- 20 equipos de LaLiga EA Sports (liga `140` en API-Football).
- 38 jornadas de liga (round-robin ida y vuelta) + Copa del Rey en jornadas 6, 18, 30 y 38.
- 5 tipos de foco de entrenamiento, 6 formaciones, 5 mentalidades, 4 intensidades, 4 estilos.
- 4 tipos de personalidad de jugador (`ambitious`, `loyal`, `greedy`, `professional`) que afectan negociación, cláusula y reacción a ofertas rivales.

---

## 2. Tecnologías y stack

| Capa | Tecnología | Versión |
|---|---|---|
| Framework UI | **Flutter** (Material 3) | SDK ≥ 3.0.0, Dart 3 |
| Lenguaje | **Dart** | 3.x |
| Base de datos local | **Isar** + `isar_flutter_libs` | `^3.1.0+1` |
| Generador de código Isar | `isar_generator` + `build_runner` | `^3.1.0+1` / `^2.4.13` |
| HTTP | `http` | `^1.6.0` |
| Variables de entorno | `flutter_dotenv` | `^6.0.1` |
| Iconos | `font_awesome_flutter` + `cupertino_icons` | `^10.7.0` / `^1.0.6` |
| Tipografía | `google_fonts` (Urbanist) | `^6.1.0` |
| Formato / fechas | `intl` | `^0.19.0` |
| Rutas del sistema | `path_provider` | `^2.1.2` |
| Lints | `flutter_lints` | `^3.0.1` |
| Icono de app | `flutter_launcher_icons` | `^0.14.4` |

### Dependencias de assets

- `assets/.env` — variable `FOOTBALL_API_KEY`.
- `assets/data/players.json` — dataset de jugadores (2,4 MB) listo para usar como *fallback* si la API no responde.
- `assets/icons/PcFutbol26.png` — icono adaptativo de la app (Android `min_sdk = 21`).

### Arquitectura lógica

- **Capa de datos**: `lib/models/*.dart` (entidades Isar `@collection`).
- **Capa de servicios / dominio**: `lib/core/*.dart` (orquestación, motor, simulaciones, lógica de negocio).
- **Capa de presentación**: `lib/screens/*.dart` + `lib/widgets/*.dart`.
- **Bootstrap**: `lib/main.dart` carga `flutter_dotenv` y arranca la `SplashScreen`, que a su vez inicializa `DatabaseService` antes de pasar a `TitleScreen`.

### Paleta de colores principal

| Uso | Color | Hex |
|---|---|---|
| Fondo principal | `Color` | `#020617` |
| Verde "PC Fútbol" | `Color` | `#DEFF9A` |
| Tarjetas / paneles | `Color` | `#0F172A` |
| Slate intermedio | `Color` | `#1E293B` |
| Rojo error | `Color` | `#DC2626` / `Colors.redAccent` |
| Ámbar alerta | `Color` | `Colors.amber` |

La paleta extendida clásica está disponible en `lib/core/pc_futbol_colors.dart`.

---

## 3. Requisitos y configuración

### Requisitos

- **Flutter SDK** ≥ 3.0 con Dart 3.
- **Android**: `minSdkVersion 21`, iOS 12+, macOS, Windows, Linux, Web.
- Clave de [**API-Football**](https://www.api-football.com/) (plan gratuito válido para pruebas).

### Instalación

1. Crear el archivo `assets/.env`:

   ```env
   FOOTBALL_API_KEY=tu_clave_aqui
   ```

2. Instalar dependencias y generar el código Isar:

   ```bash
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   ```

3. Ejecutar la aplicación:

   ```bash
   flutter run
   ```

### Variables de entorno

| Variable | Obligatoria | Descripción |
|---|---|---|
| `FOOTBALL_API_KEY` | Sí (solo primera sincronización) | Clave de `v3.football.api-sports.io`. Si está vacía, `ApiService` genera plantillas inventadas con `PlayerGenerator`. |

> El archivo real `assets/.env` del repositorio **ya contiene una clave**, pero se recomienda reemplazarla por la propia antes de publicar.

### Build runner

`build_runner` produce los archivos `*.g.dart` (esquemas Isar). Tras cualquier cambio en una `@collection` o en un `enum` `@enumerated`, vuelve a ejecutar:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Inspector Isar

`DatabaseService.init()` activa `inspector: true`. En modo debug, la consola imprime la URL `http://localhost:8080` para inspeccionar la BD en vivo.

---

## 4. Arquitectura del proyecto

El proyecto sigue un patrón **Service-Oriented** sobre una única base de datos Isar. Los servicios se inyectan con la instancia `Isar` abierta (patrón *constructor injection*) y se comunican entre sí a través de entidades persistidas, no mediante buses de eventos.

```
lib/
├── main.dart                  # Entry point + tema + carga de .env
├── core/                      # 32 servicios (lógica de negocio)
├── models/                    # 12 entidades Isar + 2 DTOs auxiliares
├── screens/                   # 26 pantallas
└── widgets/                   # 2 widgets reutilizables
```

### Principios clave

- **Un solo `Isar`** abierto por proceso. Cualquier servicio opera contra `isar.<colección>`.
- **Un solo `GameSave` activo** (id = 1). Permite saber de inmediato si hay partida en curso.
- **Trazabilidad de partidos**: `LeagueFixture` cubre liga y copa con los campos `competition = 'liga' | 'copa'` y `cupRound` (0 en liga, 1–4 en copa).
- **Cache en memoria** de clasificaciones (`LeagueService._standingCache`) para evitar escrituras por cada partido simulado.
- **Inmutabilidad de eventos de partido**: `MatchEvent` es una clase plana no-Isar; se consume en `MatchEngine.generateFullStats()` para producir `FullMatchStats` y `PlayerMatchStats`.
- **Responsive first**: `lib/core/responsive.dart` define `compact` (< 600 px), `medium` (600–839), `expanded` (≥ 840). Todas las pantallas lo usan.

---

## 5. Capa de modelos (Isar)

Todas las entidades descritas a continuación se persisten con `package:isar/isar`. Los `*.g.dart` se generan automáticamente.

### 5.1 `Player` — `lib/models/player_model.dart`

Entidad central del juego. Es el modelo de futbolista tanto para jugadores reales (API) como generados (cantera / relleno).

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | Clave primaria |
| `name` | `String` (indexado valor) | |
| `teamId` | `String` (indexado) | `'API'`, `'USER'`, `'GEN'`, `'LOAN_IN'`, `'LOAN_OUT'`, `'EDITOR'` |
| `teamApiId` | `int?` (indexado) | API ID del club. `null` para jugadores libres |
| `age` | `int` | 15–42 |
| `position` | `String` | `'GK' | 'DEF' | 'MID' | 'FWD'` |
| `stats` | `List<int>` | `[Velocidad, Tiro, Pase, Defensa, Físico]` |
| `marketValue` | `double` | Valor de mercado en € |
| `salary` | `double` | Sueldo semanal |
| `buyoutClause` | `double` | Cláusula de rescisión |
| `personality` | `Personality` (`@enumerated`) | `ambitious` / `loyal` / `greedy` / `professional` |
| `injuredDays` | `int` | Días restantes de lesión (0 = apto) |
| `suspendedMatches` | `int` | Partidos de sanción pendientes |
| `isYouth` | `bool` | Jugador de cantera (no cuenta en plantilla profesional) |
| `contractYearsRemaining` | `int` | Años de contrato restantes |
| `nationality` | `String` | Código de 3 letras (`'ESP'`, `'BRA'`, …) |
| `onLoanFromTeamApiId` | `int` | Cedido a nosotros (0 = no) |
| `onLoanUntilMatchday` | `int` | Jornada en la que expira la cesión |
| `loanedOutToTeamApiId` | `int` | Cedido a otro club |
| `loanedOutUntilMatchday` | `int` | |
| `isGenerated` | `bool` | Inventado por el motor (no API) |
| `isUnicorn` | `bool` | Apuesta joven con progresión acelerada |
| `potential` | `int` | Techo de atributos (1–99). `Unicorn` 88–99 |

Getter: `average` calcula la media de `stats`.

### 5.2 `Team` — `lib/models/team.dart`

Club (propio o rival). La enumeración `TeamTier` (`elite`, `top`, `upperMid`, `midTable`, `lowerMid`, `relegation`) determina presupuesto base y expectativas.

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `apiId` | `int` (indexado, único) | ID de la API-Football |
| `name`, `city`, `stadium` | `String` | |
| `stadiumCapacity` | `int` | Aforo base |
| `logoUrl` | `String` | URL del escudo |
| `budget` | `int` | Presupuesto inicial (calculado por tier + ajuste por posición) |
| `previousSeasonPosition` | `int` | Posición la temporada anterior (1–20) |
| `squadAverageRating` | `double` | Media de la plantilla profesional |
| `initialRealPlayersCount` | `int` | Conteo inicial |
| `initialGeneratedPlayersCount` | `int` | |

Métodos estáticos relevantes: `getTierForTeam(name)`, `getBaseBudgetForTier(tier, name)`, `calculateAdjustedBudget(base, pos, avg)`, `Team.fromJson(json)`, `expectations` (objetivo + exigencia textual), `formattedBudget` (puntos como separador de millares).

### 5.3 `GameSave` — `lib/models/game_save.dart`

`Id = 1` (partida única). Contiene todo el estado de carrera.

#### Enums auxiliares

- `GamePhasePlan`: `early`, `mid`, `late`, `veryLate`, `ifWinning`, `ifLosing`, `ifDrawing`.
- `BoardRequirementType`: `signPlayer`, `promoteYouth`, `reachPosition`, `winDerby`, `keepCleanSheets`, `scoreGoals`, `developPlayer`.

#### Objetos embebidos (`@embedded`)

- `BoardRequirement { type, description, targetValue, currentValue, completed, deadline, playerId }`.
- `FanSurvey { approvalRating, favoritePlayer, mostCriticizedPlayer, feedback, surveyDate }`.

#### Campos principales

| Campo | Tipo | Notas |
|---|---|---|
| `userTeamApiId` | `int` | Club elegido |
| `currentMatchday` | `int` | Jornada actual (1–38) |
| `totalMatchdays` | `int` | 38 por defecto |
| `staffSecretaryName/Level`, `staffPreparatorName/Level`, `staffMedicoName/Level` | `String` / `int` | Copia espejo del staff contratado |
| `seasonFinished` | `bool` | |
| `seasonNumber` | `int` | 1 = primera |
| `inCup`, `cupRound` | `bool` / `int` | Copa del Rey |
| `trophies` | `List<String>` | `'Liga 1'`, `'Copa del Rey 1'`, … |
| `matchMode` | `String` | `'resumen'` (por defecto) o `'resultado'` |
| `consecutiveRedWeeks` | `int` | Semanas en rojo (despido a las 3) |
| `financiallyDismissed` | `bool` | |
| `boardObjectiveMaxPosition` | `int` | Posición objetivo (4 = top 4, 17 = salvación, …) |
| `boardObjectiveLabel` | `String` | Etiqueta legible |
| `internationalScoutsUsed` | `int` | Scouts internacionales en la temporada |
| `currentDay` | `int` | 1–7 dentro de la semana |
| `boardAcceptance` | `int` | Confianza 0–100 |
| `boardLastFeedback` | `String` | Último informe del presidente |
| `lineupGeneratedPlayers`, `lineupTotalPlayers` | `int` | Ratio histórico para regla 70/30 |
| `trainingFocusesUsedToday` | `List<String>` | Focos consumidos hoy (se resetea cada día) |
| `teamMentality`, `teamIntensity`, `teamStyle` | enums (`@Enumerated(EnumType.name)`) | Táctica global |
| `phasePlans` | `List<String>` | Plan por fase serializado |
| `defaultFormation` | `String` | `'4-4-2'` por defecto |
| `useAutomaticPhaseAdjustments` | `bool` | |
| `boardRequirements` | `List<BoardRequirement>` | |
| `lastFanSurvey` | `FanSurvey?` | |
| `lastSurveyDate` | `DateTime?` | |
| `derbiesWon`, `cleanSheets` | `int` | Contadores de temporada |
| `fanFavoritePlayerId` | `String?` | |

### 5.4 `LeagueFixture` — `lib/models/league_fixture.dart`

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `matchday` | `int` (indexado) | Jornada 1–38 |
| `homeTeamApiId`, `awayTeamApiId` | `int` | |
| `played` | `bool` | |
| `homeGoals`, `awayGoals` | `int` | |
| `competition` | `String` | `'liga'` o `'copa'` |
| `cupRound` | `int` | 0 en liga, 1–4 en copa |

### 5.5 `CupFixture` — `lib/models/cup_fixture.dart`

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `round` | `int` | 1 octavos, 2 cuartos, 3 semifinal, 4 final |
| `homeTeamApiId`, `awayTeamApiId` | `int` | |
| `played`, `homeGoals`, `awayGoals` | `bool` / `int` | |

### 5.6 `LeagueStanding` — `lib/models/league_standing.dart`

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `teamApiId` | `int` (indexado, único) | |
| `played`, `wins`, `draws`, `losses` | `int` | |
| `goalsFor`, `goalsAgainst`, `points` | `int` | |
| `goalDifference` (getter) | `int` | `goalsFor - goalsAgainst` |

### 5.7 `TransferOffer` — `lib/models/transfer_offer.dart`

Enums: `OfferType { purchase, loanIn, loanOut, swap }`, `OfferStatus { pending, accepted, rejected, expired, negotiating }`.

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `playerId` | `int` | FK a `Player` |
| `counterpartyTeamApiId`, `counterpartyTeamName` | `int` / `String` | |
| `offerType` | `OfferType` | |
| `amount` | `double` | Importe ofertado |
| `loanMatchdays` | `int` | Para cesiones |
| `status` | `OfferStatus` | |
| `isForOurPlayer` | `bool` | `true` = oferta por jugador nuestro (venta / cesión salida) |
| `createdAt` | `DateTime` | |
| `expiresOnMatchday` | `int` | |
| `swapPlayerId`, `swapPlayerName` | `int?` / `String?` | Intercambios |
| `buybackClause`, `buybackValidYears` | `double?` / `int?` | Cláusula de recompra |
| `sellOnPercentage` | `double?` | % de venta futura |
| `loanWithPurchaseOption`, `loanPurchaseOptionAmount` | `bool?` / `double?` | Cesión con opción |
| `previousOffers` | `List<double>` | Historial |
| `negotiationRounds` | `int` | |

### 5.8 `ClubFinance` — `lib/models/finance_model.dart`

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | 1 (única) |
| `balance` | `double` | Caja (afectada por crédito) |
| `transferBudget` | `double` | Presupuesto de fichajes |
| `wageBill` | `double` | Masa salarial actual |
| `maxWageBill` | `double` | Tope de masa salarial |
| `ticketPrice` | `double` | Precio de la entrada |
| `stadiumMaintenance` | `double` | Coste de mantenimiento del estadio |
| `sponsorIncomePerMatch` | `double` | Suma de patrocinadores |
| `sponsorSlot{1,2,3}Brand` / `…Income` | `String` / `double` | Slots publicitarios |
| `stadiumExtraCapacity` | `int` | Aforo extra por obras |
| `loanAmount`, `loanWeeks` | `double` / `int` | Préstamo bancario persistente |

### 5.9 `UserLineup` — `lib/models/user_lineup.dart`

Convocatoria del usuario (id = 1).

| Campo | Tipo | Notas |
|---|---|---|
| `starterPlayerIds` | `List<int>` | 11 titulares |
| `benchPlayerIds` | `List<int>` | 7 suplentes |
| `formation` | `String` | `'4-4-2'`, `'4-3-3'`, `'3-5-2'`, `'5-3-2'`, `'4-2-3-1'`, `'4-5-1'` |

### 5.10 `Staff` — `lib/models/staff.dart`

Modelo Isar persistente (entidad histórica). Usado por `StaffService`.

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `name` | `String` (indexado valor) | |
| `role` | `String` (indexado) | `'coach' | 'assistant' | 'physio' | 'scout'` |
| `level` | `int` | 1–10 (5 = máximo entrenable) |
| `salary` | `double` | Mensual |
| `contractYearsRemaining` | `int` | |
| `nationality` | `String` | |
| `roleDisplay` (getter) | `String` | Etiqueta en español |

### 5.11 `StaffMember` — `lib/models/staff_member.dart`

DTO no persistente. Usado por `StaffGenerator` y la pantalla de selección de staff.

```dart
enum StaffRole { secretario, preparador, medico, psicologo, juvenil }

class StaffMember {
  final String name;
  final StaffRole role;
  final int level;       // 1–5 estrellas
  final double salary;
  final String description;
}
```

### 5.12 `GameMessage` — `lib/models/game_message.dart`

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id` autoincrement | |
| `createdAt` | `DateTime` | |
| `title`, `body` | `String` | |
| `read` | `bool` | |
| `type` | `MessageType` (`@enumerated`) | `match`, `transfer`, `training`, `board`, `general`, `press` |

### 5.13 `MatchEvent` — `lib/models/match_event.dart`

DTO inmutable (no Isar). Cada evento del motor de partido.

```dart
enum EventType { goal, card, substitution, injury, chance, comment }

class MatchEvent {
  final int minute;
  final String description;
  final EventType type;
  final bool isHomeTeam;
  final int? homeScore;
  final int? awayScore;
  final bool isFullTime;
  final bool isHalftime;
  final int? playerId;
  final bool cardIsRed;
  final int injuryDays;
}
```

### 5.14 `MatchStats` — `lib/models/match_stats.dart`

Dos DTOs no Isar usados en la hoja de partido y prensa.

- `PlayerMatchStats { playerId, playerName, position, minutesPlayed, goals, assists, yellowCards, redCard, rating, saves, shotsOnTarget }`.
- `FullMatchStats { homeGoals, awayGoals, homeShots, awayShots, homeShotsOnTarget, awayShotsOnTarget, homeCorners, awayCorners, homeFouls, awayFouls, homeOffsides, awayOffsides, homeYellowCards, awayYellowCards, homeRedCards, awayRedCards, homePlayerStats, awayPlayerStats }` + getter `manOfTheMatch`.

### 5.15 `Sponsor` — `lib/models/sponsor.dart`

```dart
class Sponsor {
  final String brandName;
  final double paymentPerMatch;
  final int contractDuration;   // partidos o semanas
  final String category;        // 'Valla' | 'Camiseta' | 'Estadio'
}
```

### 5.16 `EditorConfig` — `lib/models/editor_config.dart`

| Campo | Tipo | Notas |
|---|---|---|
| `id` | `Id = 1` | Único |
| `leagueName` | `String` | `'LaLiga EA Sports'` por defecto |
| `seasonLabel` | `String` | `'2025/26'` |
| `userTeamNameOverride` | `String` | Si no vacío, sustituye el nombre del club en la UI |

---

## 6. Capa de servicios (core/)

Todos los servicios reciben la instancia de `Isar` por constructor. Los *stubs* no persistentes se construyen bajo demanda.

### 6.1 `api_service.dart` — `ApiService`

Cliente HTTP para `https://v3.football.api-sports.io`. Política: **solo consulta la API si la BD está vacía** (no se re-sincroniza nunca). Métodos principales:

- `syncLeagueTeams(leagueId, db)`: descarga los 20 equipos de LaLiga (prueba temporadas `2024`, `2023`, `2025`).
- `syncTeamSquad(teamId, db, {force})`: descarga la plantilla real de un equipo. Si la API falla, recurre a `_fallbackGeneratedSquad`.
- Helpers: `_translatePosition`, `_statsForPosition`, `_estimateValue`, `_parseAge`, `_hasApiErrors`.

### 6.2 `board_service.dart` — `BoardService`

Lógica de la presidencia y objetivos.

- `assignObjectives(save, userTeam)`: clasifica al club según presupuesto medio de la liga y asigna `boardObjectiveMaxPosition` (4, 10 o 17) y `BoardRequirement`s (canteranos, porterías a cero, delantero estrella si presupuesto ≥ 100 M€).
- `conductWeeklyMeeting({save, userTeam, leaguePosition, finance})`: genera una reunión aleatoria (`MeetingTopic { results, finances, transfers, youth, tactics, morale }`).
- `evaluateWeeklyAcceptance({save, userTeam, leaguePosition, finishedMatchday})`: recalcula `boardAcceptance` (0–100) cada jornada. Pesos: 40 % resultados, 35 % finanzas, 25 % gestión.
- `presidentDismissesManager(save, userTeam)`: probabilidad 0 % si `boardAcceptance > 20`, 55 % si ≤ 20, 85 % si ≤ 10.
- `evaluateSeasonEnd(save, finalPosition)`: despido por incumplimiento con probabilidad modulada por el nivel del secretario.
- `maybeMidSeasonWarning(save, position)`: ultimátum en la jornada 19.
- `conductFanSurvey(save, players)`: encuesta de aprobación.
- `generatePressRumor(save, userTeam, otherClub?)`: rumores a mensajes `press`.
- `updateRequirementsProgress(save, {youthPromoted, cleanSheetsAdded, signedPlayer})`: actualiza progreso de `BoardRequirement` y suma `+5` confianza al completarlo.

### 6.3 `calendar_service.dart` — `CalendarService`

Calendario unificado (liga y copa en la misma jornada). Constantes:

```dart
static const cupMatchdays = {1: 6, 2: 18, 3: 30, 4: 38};
static const int matchdayDay = 7;
```

- `advanceDay(userTeamApiId)`: avanza el día 1→7; bloquea el avance si hay partidos pendientes en día 7; dispara `TransferAiService.generateDailyMarketActivity` y notifica al manager.
- `getUserPendingFixtures(userTeamApiId)`: pendientes de la jornada actual (liga + copa si aplica).
- `opponentFor(fixture, userTeamApiId)`: rival.
- `userIsHome(fixture, userTeamApiId)`.
- `recordUserMatch({fixture, userTeamApiId, userGoals, opponentGoals, userWasHome, userTeam})`: aplica marcador, actualiza standings, dispara prensa y, si no quedan más pendientes del usuario, cierra la jornada.
- `_completeMatchday(...)`: simula el resto de partidos de la IA, deduce nóminas/seguro de staff, tick de recuperación de lesiones, tick de cesiones, aplica ingresos por partido del usuario, evalúa la confianza del consejo, evalúa despido, avanza `currentMatchday` y, al llegar a la 38, llama a `_finalizeAndChainNextSeason` (encadena automáticamente la siguiente temporada regenerando liga y copa).
- `_finalizeAndChainNextSeason(...)`: cierra temporada, evalúa despido, regenera calendario, scout de cantera, ofertas de mercado.
- `_resolveCup(...)`: maneja eliminatorias; en caso de empate se lanza moneda.
- `_scheduleCupFixture(...)` e `initCupForSeason(...)`.

### 6.4 `cup_service.dart` — `CupService`

Copa del Rey simplificada. Mantiene la colección `CupFixture`.

- `roundName(round)`: 'Octavos', 'Cuartos', 'Semifinal', 'Final'.
- `initCupForSeason(userTeamApiId)`: vacía `cupFixtures`, crea cruce de octavos, fija `inCup = true`, `cupRound = 1`.
- `hasCupMatchThisMatchday(leagueMatchday, userTeamApiId)`.
- `getCurrentUserCupFixture()` / `getCupOpponent(userTeamApiId)` / `userIsHome(userTeamApiId)`.
- `recordCupResult({userTeamApiId, userGoals, opponentGoals, userWasHome})`: gestiona eliminación, clasificación y título.

### 6.5 `database_service.dart` — `DatabaseService`

Inicialización y *gateway* de Isar. Abre todas las colecciones:

```
Player, ClubFinance, Team, GameSave, LeagueFixture, LeagueStanding,
UserLineup, GameMessage, CupFixture, TransferOffer, EditorConfig, Staff
```

- `init()`: abre Isar en `getApplicationDocumentsDirectory()`; si la BD está vacía, sincroniza con la API y completa plantillas con `SquadService.ensureAllTeams()`. Inicializa finanzas y la `EditorConfig`.
- `saveTeam`, `savePlayers`, `replaceTeamSquad`, `getAllTeams`, `getAllPlayers`, `getAllFixtures`, `getPlayersByTeam(apiId, {professionalsOnly})`, `expandStadium`, `effectiveStadiumCapacity`, `close`.
- Constructor alternativo `DatabaseService.connected(isar)` para servicios que ya tienen la instancia abierta.

### 6.6 `editor_service.dart` — `EditorService`

- `getConfig()` / `saveConfig(cfg)`.
- `updatePlayer(player)`: edición manual de un jugador.
- `createCustomPlayer(teamApiId)`: jugador plantilla para el editor.

### 6.7 `finance_service.dart` — `FinanceService`

- `initFinances(userTeam)`: crea la `ClubFinance` con balance, presupuesto de fichajes, masa salarial, topes, patrocinadores iniciales, etc.
- `signPlayer(target, agreedPrice, userTeamApiId)`: valida presupuesto y masa salarial, actualiza, asigna el jugador al club.
- `sellPlayer(player, userTeamApiId)`: exige plantilla mínima (16 profesionales), descuenta sueldo, ingresa `marketValue * 0.85` a caja, `* 0.6` a presupuesto de fichajes.
- `deductStaffAndWages(save)`: deducciones semanales (nóminas + amortización de crédito al 10 % anual).

### 6.8 `financial_guard_service.dart` — `FinancialGuardService`

- `afterMatchdayWeek(save, clubName)`: incrementa `consecutiveRedWeeks` si `balance < 0` y dispara despido a la tercera semana.

### 6.9 `game_calendar.dart` — `GameCalendar`

Fechas reales para la temporada:

- `seasonStartMonday(seasonNumber)`: lunes previo al inicio de la liga (T1 ≈ 11-ago-2025).
- `dateFor({seasonNumber, matchday, dayOfWeek})`: lunes base + `(matchday-1)*7 + (dayOfWeek-1)` días.
- `formatHeader`, `formatAdvanceOverlay`, `formatMatchdaySunday`, `formatShort`, `nextAfterAdvance`, `seasonLabel`.

### 6.10 `game_engine.dart` — `GameEngine`

Stub minimalista (`calculatePlay(attacker, defender)`) para simular una jugada textual. Conserva la firma histórica por compatibilidad.

### 6.11 `game_session_service.dart` — `GameSessionService`

Orquesta el ciclo de vida de la partida.

- `getSave()`, `hasActiveSave()`, `hasAnySave()`, `getUserTeam()`, `getCurrentUserFixture()`, `getCurrentOpponent()`.
- `checkAndAdvanceMatchday(userTeam)`: si no quedan pendientes del usuario, simula el resto con `LeagueService.simulateRestOfMatchday` y avanza `currentMatchday`.
- `startSeason(userTeam, staff)`: genera calendario, crea `GameSave`, asigna objetivos, inicializa finanzas, asegura plantillas, inicializa copa, scout de cantera.
- `startNextSeason(userTeam)`: re-inicia temporada tras `seasonFinished = true`.
- `professionalSquadCount(userTeamApiId)`, `meetsMinimumSquad(userTeamApiId)`.
- `isDismissed()`, `trainingMultiplier()` (1.0 + 0.08 * (staffPreparatorLevel − 1)).

### 6.12 `international_scout_service.dart` — `InternationalScoutService`

- `runScoutMission(userTeamApiId, {cost = 350000})`: cuesta 350 k €, escoge un jugador aleatorio de la BD, le asigna una nacionalidad internacional aleatoria (BRA, ARG, FRA, POR, NED, GER, ITA, ENG, URU, COL) y notifica al usuario.

### 6.13 `league_service.dart` — `LeagueService`

- `createSeason(userTeamApiId)`: round-robin de Berger sobre los 20 equipos; el club del usuario va primero para garantizar mitad de jornadas como local. Genera `LeagueFixture` y `LeagueStanding` (38 jornadas = 2 vueltas).
- `getUserFixture(userTeamApiId, matchday)`: busca el partido de liga de la jornada.
- `simulateRestOfMatchday(matchday, userTeamApiId)`: simula y actualiza la cache de standings en una sola transacción.
- `getStandingsSorted()`, `getUserLeaguePosition(userTeamApiId)`, `getStanding(teamApiId)`.
- API pública para uso desde otros servicios: `loadStandingsCachePublic`, `updateStandingInMemoryPublic`, `userPositionFromCachePublic`, `persistStandingsCache`, `simulateFixtureScore`, `applyMatchFinancePublic`.
- `applyMatchFinance(...)`: ingresos por taquilla (estimación por fill-rate) + patrocinadores − mantenimiento si se juega como local; inyecta 12 % al presupuesto de fichajes.
- Helpers internos: `_squadStrength`, `_simulateScore`, `_estimateAttendance`.

### 6.14 `lineup_guard.dart` — `LineupGuard`

`LineupGuard.ensureBeforeMatch(context, isar, userTeam)`: si la convocatoria no es válida, muestra un diálogo modal que lleva a la pantalla de alineación y bloquea el partido.

### 6.15 `lineup_service.dart` — `LineupService`

Constantes: `requiredStarters = 11`, `requiredBench = 7`, `requiredMatchdaySquad = 18`, `generatedStyleThreshold = 0.25`.

- `getLineup()`: devuelve o crea la `UserLineup` singleton (id 1).
- `getStarters(teamApiId)`, `getBench(teamApiId)`, `getFormation()`, `saveFormation(formation)`.
- `hasValidLineup(teamApiId)`: comprueba 11 titulares con portero + 7 suplentes, sin lesiones ni sanciones.
- `clearLineup()`: vacía titulares/banquillo pero conserva formación.
- `saveLineup({starterIds, benchIds, formation?})`: persiste y actualiza contadores `lineupGeneratedPlayers` / `lineupTotalPlayers` para la regla 70/30.
- `shouldEnforceRatio({currentMatchday, lineupGeneratedPlayers, lineupTotalPlayers})`: si la ratio de jugadores `isGenerated` históricos ≥ 25 % después de la jornada 1, la regla 70/30 sigue activa.
- `autoPickMatchdaySquad(teamApiId)`: 1 GK + 4 DEF + 4 MID + 2 FWD + 7 banquillo.

### 6.16 `loan_service.dart` — `LoanService`

- `loanInPlayer(player, fromTeamApiId, userTeamApiId, matchdays)`.
- `loanOutPlayer(player, toTeam, userTeamApiId, matchdays)`.
- `tickLoanContracts(userTeamApiId, currentMatchday)`: revisa vencimientos y devuelve jugadores automáticamente.

### 6.17 `match_discipline_service.dart` — `MatchDisciplineService`

- `applyFromEvents(events, userTeamApiId)`: traduce `MatchEvent.card` → `suspendedMatches` (1 o 2) y `MatchEvent.injury` → `injuredDays`.
- `tickRecovery(userTeamApiId)`: descuenta 1 día de lesión y 1 partido de sanción por jornada.

### 6.18 `match_engine.dart` — `MatchEngine`

Motor de partido estilo PCF7. Métodos principales:

- `simulateMatch({home, away, homePlayers, awayPlayers, homeFormation, awayFormation, medicoLevel})` → `List<MatchEvent>`: dos periodos (1–45, 46–90).
- `simulatePeriod(...)` minuto a minuto: probabilidad de gol ponderada por `homeBias = homeStrength / (homeStrength + awayStrength)` y `homeConcedeBias = awayStrength / (homeDef + awayDef)`. Maneja goles, tarjetas (82 % amarillas, 18 % rojas), lesiones (chance modulada por `medicoLevel`, 12–40 %), comentarios de presión.
- `playPeriod(...)` / `playMatch(...)`: devuelven `Stream<MatchEvent>` con delay configurable por `speedMultiplier`.
- `_squadStrength(players)`: media de stats, ignorando lesionados y sancionados.
- `_pickScorer(players)`: prioriza delanteros.
- `generateFullStats({events, homePlayers, awayPlayers})`: produce `FullMatchStats` (tiros, córners, faltas, tarjetas, …) y el `manOfTheMatch`.

### 6.19 `message_service.dart` — `MessageService`

Buzón unificado: `add(...)`, `unreadCount()`, `markAllRead()`. Insertado en escritura por más de 30 lugares del juego.

### 6.20 `pc_futbol_colors.dart` — `PCFutbolColors`

Paleta clásica: `primaryDark #0A2463`, `primaryMedium #1E3F8A`, `primaryLight #3E88FF`, `classicGreen #00AA00`, `lightGreen #88FF88`, `accentYellow #FFFF00`, `errorRed #FF0000`, `accentOrange #FFAA00`, etc.

### 6.21 `player_generator.dart` — `PlayerGenerator`

Generador de jugadores inventados (fallback de API y de progresión de carrera).

- `generateFullSquad(teamApiId, {size = 24, seasonNumber})`.
- `generateSupplementalPlayers(teamApiId, count, {seasonNumber})`.
- `generateYouthReplacements(teamApiId, count, {seasonNumber})`: ya como cantera (`isYouth = true`, edad 15–18).
- `generateSpecificPosition(teamApiId, position, seasonNumber)`.
- Helpers: `salaryFromValue`, `contractDuration`, `buyoutClause` (multiplicadores por personalidad: greedy 4.5–5x, ambitious 2.8–4x, loyal 2.2–2.8x, professional 3.0–3.5x, contrato 1 año → 1.3x).

### 6.22 `player_progression_service.dart` — `PlayerProgressionService`

Ejecuta el avance de fin de temporada:

1. Envejece a todos los jugadores +1.
2. Aplica la curva por edad/posición (picos diferenciados para Velocidad/Físico vs. Tiro/Pase/Defensa).
3. Decaimiento extra por lesiones > 60 días.
4. Recalcula valor, sueldo y cláusula.
5. Reduce contrato, retira a mayores de 36 (35 con 55 % chance, 34 con 90 días de lesión con 30 %).
6. Genera un joven de cantera por retirado (`PlayerGenerator.generateYouthReplacements`).
7. Notifica al manager y avisa de contratos en último año.

### 6.23 `press_service.dart` — `PressService`

Notas de prensa estilo PCF7.

- `generateMatchReport({teamName, opponentName, ourGoals, theirGoals, stats, wasHome})`: produce un artículo con resultado, evento clave (córners, tarjetas, festival de goles) y `manOfTheMatch`.
- Stubs de compatibilidad: `publishMatchReaction`, `publishTransferNews`.

### 6.24 `responsive.dart` — `Responsive`

Helpers de diseño: `breakpoint(context)`, `value<T>(...)`, `horizontalPadding`, `verticalPadding`, `gridColumns`, `gridAspectRatio`, `maxContentWidth`, `textScale`, `page({context, child, constrainWidth, padding})`. Enum `ScreenSize { compact, medium, expanded }`.

### 6.25 `scout_service.dart` — `ScoutService`

`generateScoutReport(opponent, userTeamApiId)` → `ScoutReport { teamStrength, keyStrength, keyWeakness, dangerPlayers, recommendedTactic, recommendedMentality, recommendedStyle, prediction }`. Analiza medias por posición y clasificación; recomienda 5-3-2 + defensivo + contraataque para rivales fuertes (≥ 80) y 4-3-3 + ofensivo + posesión para débiles (≤ 60).

### 6.26 `squad_service.dart` — `SquadService`

Garantiza la regla 70/30 en la **configuración inicial** (antes de que haya partida).

- `ensureSquad(teamApiId, {tryApiFirst})`: solo interviene si no hay `GameSave` activo.
- `_enforce7030Rule(...)`: baja API, recorta generados sobrantes, rellena con `PlayerGenerator` y aplica requisitos posicionales (`{GK: 2, DEF: 5, MID: 5, FWD: 5}`).
- `_updateTeamStats(...)`: recalcula `squadAverageRating` y `budget` ajustado.
- `ensureAllTeams()`: itera todos los equipos con `Future.delayed(400 ms)` para no agotar la cuota de la API.

### 6.27 `staff_generator.dart` — `StaffGenerator`

Genera candidatos a `secretario`, `preparador` y `médico` con nombres españoles aleatorios, niveles ponderados (22 % nivel 1, 23 % nivel 2, 23 % nivel 3, 20 % nivel 4, 12 % nivel 5) y descripciones textuales por nivel/rol.

### 6.28 `staff_service.dart` — `StaffService`

- `syncGameSave()`: copia el staff actual al `GameSave` (coach → secretary, assistant → preparator, physio → medico).
- `getStaff()`, `getByRole(role)`.
- `hireFromCandidate(staff)`: inserta, notifica, sincroniza.
- `trainStaff(staff, availableBudget)`: sube nivel (máx. 5) a cambio de 1.5× su salario; aumenta su sueldo 10 %.
- `fireStaff(staff)`: elimina y notifica.

### 6.29 `tactics_service.dart` — `TacticsService`

Enums: `TeamMentality { veryDefensive, defensive, balanced, attacking, veryAttacking }`, `TeamIntensity { low, normal, high, veryHigh }`, `TeamStyle { possession, direct, counterAttack, longBall }`. Formaciones: `['4-4-2', '4-3-3', '3-5-2', '5-3-2', '4-2-3-1', '4-5-1']`.

- `formationLabel`, `mentalityLabel`, `intensityLabel`, `styleLabel`.
- `fullModifiers({formation, mentality, intensity, style})` → `{attack, defense, possession, energy}`.
- `_formationModifiers(formation)` → modificador base.
- `modifiers(formation)` y `label(formation)`: compatibilidad.

### 6.30 `training_engine.dart` — `TrainingEngine`

Enum `TrainingFocus { fitness, shooting, passing, defense, tactical }`. Mapa a índices de stat: `fitness→4, shooting→1, passing→2, defense→3, tactical→2`.

- `getSelectionLimit(staffMultiplier)`: 3 si multiplier ≤ 1, 5 si ≤ 1.25, 8 en otro caso.
- `autoSelectConfiguration({teamPlayers, maxCupos, usedFocuses})`: elige foco no usado y prioriza unicorns, jóvenes ≤ 21 y jugadores con mayor margen hasta `potential`.
- `trainSelectedPlayers(playerIds, focus, {staffMultiplier})`: respeta el bloqueo de foco diario; aplica multiplicadores (ambitious 1.2, unicorn 1.85, ≤ 21 1.15, staffMultiplier); solo mejora si supera un umbral aleatorio y si no está al `potential`.

### 6.31 `transfer_ai_service.dart` — `TransferAiService`

IA de mercado.

- `_prestige(name)` / `_estimatedBudget(prestige)`: 0–3 según club; presupuesto estimado 10–120 M€.
- `_personalityOfferMultiplier(player, buyerPrestige)`: greedy 1.25, ambitious 0.95–1.10, loyal 1.15, professional 1.00.
- `_loyalPlayerRefuses(...)`: 60 % chance de rechazo si el rival tiene `apiId` próximo.
- `generateDailyMarketActivity(userTeamApiId, currentMatchday, currentDay)`.
- `generateMatchdayOffers(userTeamApiId, nextMatchday)`: genera oferta por jugador de tu plantilla con presupuesto del comprador, modo cesión si no puede pagar, hint de personalidad en el mensaje, y posible oferta de cesión entrante.
- `pendingOffers()`: ofertas pendientes no expiradas.
- `acceptOffer(offer, userTeamApiId)`: ejecuta el traspaso/cesión y actualiza finanzas.
- `rejectOffer(offer)`.

### 6.32 `transfer_manager_service.dart` — `TransferManagerService`

Mercado activo del usuario (enviar ofertas, negociar, intercambios).

- `makeOfferForPlayer(target, team, amount, {includeBuyback, buybackAmount, sellOnPercentage, swapPlayers})`.
- `negotiateOffer(offer, newAmount)`: añade a `previousOffers`, marca `negotiating`, simula respuesta: aceptación, contraoferta o rechazo.
- `_simulateNegotiationResponse`, `_calculateAcceptChance`.
- `offerLoanWithOption(player, team, matchdays, optionAmount)`.
- `getAvailablePlayers(userTeamApiId, {position, maxPrice, minRating})`.
- `getTransferRecommendations(userTeamApiId)`: posiciones con cobertura < {GK 2, DEF 5, MID 5, FWD 3} + gemas si presupuesto > 30 M€.
- `proposeSwap({ourPlayer, targetPlayer, targetTeam, additionalCash})`.

### 6.33 `youth_service.dart` — `YouthService`

- `getYouthSquad(teamApiId)`.
- `scoutYouth({teamApiId, count})`: añade `count` canteranos jóvenes.
- `promoteToFirstTeam(player)`: quita `isYouth`, fuerza `buyoutClause = marketValue * 4.0`.

---

## 7. Capa de pantallas (screens/)

Todas comparten `backgroundColor = 0xFF020617`, fuente Urbanist y `Responsive.page(...)`.

| Pantalla | Archivo | Propósito |
|---|---|---|
| `SplashScreen` | `splash_screen.dart` | Animación de logo + estado de carga; `DatabaseService.init()`; transición a `TitleScreen`. |
| `TitleScreen` | `title_screen.dart` | Pantalla de título: CONTINUAR / NUEVA PARTIDA / DEBUG. Detecta si existe `GameSave`. |
| `TeamSelectionScreen` | `team_selection_screen.dart` | Tarjetas *flip* de los 20 equipos de LaLiga. Selección con `HapticFeedback` y arranque de temporada. |
| `MainMenuScreen` | `main_menu_screen.dart` | El "despacho" del manager. Grid de 16 accesos, header con Temporada/Jornada/Fecha/Confianza, *next match bar* con animación de calendario al pasar día. |
| `SquadScreen` | `squad_screen.dart` | Plantilla: lista ordenada por posición (GK→DEF→MID→FWD) y media; acceso al detalle. |
| `LineupScreen` | `lineup_screen.dart` | Convocatoria: titulares + banquillo, validación de 11 + 7, selección de formación. |
| `AdvancedTacticsScreen` | `advanced_tactics_screen.dart` | Tabs de táctica (mentalidad, intensidad, estilo, formación, plan por fase) y **scouting del próximo rival** (`ScoutReport`). |
| `TrainingScreen` | `training_screen.dart` | Selección de foco (5), jugadores (3/5/8 según staff), entrenamiento manual o automático. |
| `MatchDayScreen` | `match_day_screen.dart` | Partido: marcador, ticker de eventos, modo resumen (animado) o resultado (instantáneo), cambios al descanso y en tiempo, hoja de partido y prensa al final. |
| `TransferMarketScreen` | `transfer_market_screen.dart` | Búsqueda de jugadores, recomendaciones y nuestros transferibles. |
| `TransferOffersScreen` | `transfer_offers_screen.dart` | Bandeja de ofertas (IA e internacionales) con aceptar/rechazar. |
| `TransferNegotiationScreen` | `transfer_negotiation_screen.dart` | Negociación de fichaje con cláusulas (opción de compra, % venta futura) y simulación de respuesta. |
| `InternationalScoutScreen` | `international_scout_screen.dart` | Informe internacional (350.000 €). |
| `EditorScreen` | `editor_screen.dart` | Editor de liga/club y edición de jugadores. |
| `FinanceScreen` | `finance_screen.dart` | Balance, presupuesto de fichajes, masa salarial, precio de entrada, mantenimiento, crédito bancario, proyección de ingresos. |
| `StadiumScreen` | `stadium_screen.dart` | Ampliación de grada, patrocinadores (vallas), oferta de obras. |
| `StaffScreen` | `staff_screen.dart` | Contratación, mejora y despido de staff técnico. |
| `FullCalendarScreen` | `full_calendar_screen.dart` | Calendario completo de la temporada con formato de fechas reales. |
| `ClubManagementScreen` | `club_management_screen.dart` | Acceso a cantera, secretaría y sala de trofeos. |
| `YouthAcademyScreen` | `youth_academy_screen.dart` | Cantera: jugadores jóvenes y promoción al primer equipo. |
| `TrophyRoomScreen` | `trophy_room_screen.dart` | Sala de trofeos (Liga, Copa) y posición final. |
| `LeagueTableScreen` | `league_table_screen.dart` | Clasificación de LaLiga en vivo (suscripción a `leagueStandings.where().watch`). |
| `SecretaryScreen` | `secretary_screen.dart` | Buzón con filtros (Todos, Prensa, Presidente). |
| `PresidentScreen` | `president_screen.dart` | Confianza, feedback, audiencia con el presidente. |
| `DebugDatabaseScreen` | `debug_database_screen.dart` | Solo `kDebugMode`: jugadores, equipos, save con filtros. |

---

## 8. Capa de widgets (widgets/)

| Widget | Archivo | Descripción |
|---|---|---|
| `MatchSubstitutionSheet` | `match_substitution_sheet.dart` | Bottom sheet que muestra **"Área técnica / cambios"** o **"Descanso — cambios y táctica"**. Permite cambiar formación, sacar un jugador y meter a uno del banquillo (máx. 5 cambios). Devuelve `MatchSubstitutionResult { onField, bench, formation, substitutionsUsed }`. |
| `PlayerRadarChartPainter` | `radar_chart.dart` | `CustomPainter` que dibuja la telaraña de stats (5 ejes) para la pantalla de detalle de jugador. |

---

## 9. Cómo jugar (gameplay)

> Resumen práctico, basado en el README y el flujo real implementado.

### 9.1 Nueva partida

1. **Splash** → carga de BD (sincroniza API solo si está vacía).
2. **Title** → pulsa **NUEVA PARTIDA**.
3. **Selección de equipo**: tarjeta *flip* con cada club (objetivo y exigencia de la directiva visibles).
4. **Contrata cuerpo técnico** (secretario, preparador, médico) en el menú **STAFF** (8 candidatos por rol generados por `StaffGenerator`).
5. El juego crea la temporada 1, genera el calendario de 38 jornadas, asigna objetivos y arranca en la **Jornada 1 / Día 1** (lunes).

### 9.2 El despacho (menú principal)

16 accesos directos:

```
PLANTILLA · ALINEACIÓN · TÁCTICAS · ENTRENO · MERCADO · OFERTAS ·
OJEADOR · EDITOR · FINANZAS · ESTADIO · STAFF · CALENDARIO ·
CLUB · PRESIDENTE · CLASIFIC. · MENSAJES
```

El botón **PASAR DÍA** avanza el reloj. El **chip PARTIDO** (verde lima) en la parte inferior permite jugar; está bloqueado hasta el día 7 (domingo) si hay jornada pendiente.

### 9.3 Modo de partido

Dos modos seleccionables desde `GameSave.matchMode`:

- **RESUMEN** (por defecto, como PCF7): ticker minuto a minuto, goles, tarjetas, lesiones, comentarios, descanso con **área técnica** (cambios y táctica), final con hoja de partido y prensa.
- **RESULTADO**: simulación instantánea; salta al marcador, hoja y notas de prensa.

`MatchEngine` y `MatchDisciplineService` aplican lesiones y sanciones a los jugadores de tu equipo tras el partido.

### 9.4 Liga y Copa

- **Liga**: 38 jornadas, round-robin ida y vuelta; el calendario lo regenera `LeagueService.createSeason` cada nueva temporada.
- **Copa del Rey**: 4 rondas en jornadas 6, 18, 30 y 38. Si caes eliminado, `inCup = false` y no vuelves a entrar.
- **Jornada doble**: en las jornadas donde coincide copa y liga, debes jugar **ambos** partidos antes de pasar al lunes siguiente (lo impide `CalendarService.advanceDay`).
- **Simulación de la IA**: el resto de partidos se simula automáticamente al cerrar la jornada, actualizando clasificación y finanzas.

### 9.5 Temporadas encadenadas

- Al terminar la 38, `_finalizeAndChainNextSeason` se ejecuta **automáticamente**:
  - `PlayerProgressionService.runEndOfSeason` envejece, mejora, retira y reemplaza jugadores.
  - Si `position == 1` se añade trofeo `Liga N`.
  - `LeagueService.createSeason` regenera el calendario.
  - `CupService.initCupForSeason` reinicia la Copa.
  - `YouthService.scoutYouth` añade 4 canteranos.
  - `TransferAiService.generateMatchdayOffers` lanza ofertas de mercado.
  - Se añade el mensaje **"Temporada N"** al buzón.
- Si el manager ha sido despedido (`financiallyDismissed = true`), el flujo se detiene y la partida queda en estado terminal.

### 9.6 Mercado, ofertas y editor

- **MERCADO**: búsqueda por posición/media, recomendaciones automáticas y panel de transferibles.
- **OFERTAS**: bandeja con ofertas de la IA, internacionales y propias. Aceptar ejecuta el traspaso/cesión.
- **OJEADOR** (internacional): informe de 350.000 € que reasigna una nacionalidad aleatoria a un jugador.
- **EDITOR**: cambia nombre de liga y club (vía `EditorConfig`); edición manual de stats de jugadores.

### 9.7 Prensa, presidente y quiebra

- **Prensa** (mensajes `press`): rumores, resultados, fichajes.
- **Presidente**: audiencias con `BoardService.conductWeeklyMeeting`; confianza (`boardAcceptance`) cae si los resultados, finanzas o plantilla no cumplen.
- **Despido deportivo**: `presidentDismissesManager` con probabilidades 55 % / 85 % según `boardAcceptance`.
- **Quiebra**: 3 semanas consecutivas en números rojos → `FinancialGuardService.afterMatchdayWeek` marca `financiallyDismissed = true`.

---

## 10. Flujo de datos

```
┌──────────────────┐    1ª vez    ┌────────────────────┐
│  API-Football    │ ──────────► │  Isar (persistente) │
│  (v3.football.   │             │  players, teams,   │
│   api-sports.io) │ ◄────────── │  finances, fixtures│
└──────────────────┘   lectura   └─────────┬──────────┘
                                             │
                            ┌────────────────┼─────────────────────┐
                            ▼                ▼                     ▼
                   ┌────────────────┐  ┌──────────────┐   ┌────────────────┐
                   │  Servicios     │  │  Calendario  │   │   Pantallas    │
                   │  (core/)       │  │  + motor de  │   │  (screens/)    │
                   │                │  │  partido     │   │                │
                   └────────┬───────┘  └──────┬───────┘   └────────┬───────┘
                            │                │                    │
                            ▼                ▼                    ▼
                   ┌──────────────────────────────────────────────────┐
                   │  Isar (cache de standings, save, finances…)      │
                   └──────────────────────────────────────────────────┘
```

### Detalle del ciclo de un partido

1. El manager pulsa el **chip de partido** en `MainMenuScreen`.
2. `LineupGuard.ensureBeforeMatch` valida la convocatoria (11+1 portero+7 banquillo). Si falta, abre `LineupScreen`.
3. `MatchDayScreen._prepareMatch` carga la convocatoria, el `matchMode` y el `medicoLevel`.
4. Se ejecuta `MatchEngine.playMatch` (o `simulateMatch` si es modo resultado), emitiendo `MatchEvent` en stream.
5. El usuario puede **pausar** y abrir `MatchSubstitutionSheet`; al descanso, abre el sheet en modo "DESCANSO".
6. Al final, `MatchDisciplineService.applyFromEvents` aplica lesiones/sanciones.
7. `CalendarService.recordUserMatch` graba el resultado, actualiza standings y, si no quedan más pendientes, llama a `_completeMatchday`.
8. `_completeMatchday` simula los partidos restantes de la jornada, deduce nóminas, dispara mensajes y evalúa la confianza del presidente.

---

## 11. Generación de código

Isar requiere un archivo `*.g.dart` por cada `@collection` con los esquemas serializables.

```bash
# 1) Instalar dependencias
flutter pub get

# 2) Generar / regenerar todos los *.g.dart
dart run build_runner build --delete-conflicting-outputs

# 3) (opcional) Modo watch durante el desarrollo
dart run build_runner watch --delete-conflicting-outputs
```

El flag `--delete-conflicting-outputs` borra archivos `.g.dart` obsoletos al renombrar o eliminar modelos.

> Tras cualquier cambio en `lib/models/*.dart`, vuelve a ejecutar el paso 2.

`flutter_launcher_icons` también está configurado (`pubspec.yaml`) para regenerar los iconos desde `assets/icons/PcFutbol26.png`.

---

## 12. Notas y consideraciones

- **Cuota de la API**: la primera sincronización descarga los 20 equipos y sus plantillas de LaLiga (liga `140`). Eso son ~20–25 llamadas (1 por equipo + 1 por plantilla). El plan gratuito de API-Football es válido para pruebas; si te quedas sin cuota, `ApiService` recurre a `PlayerGenerator` para inventar jugadores.
- **Datos estimados**: el valor de mercado, salario, cláusula de rescisión y stats de jugadores de la API son **estimados** cuando API-Football no los proporciona (lo cual es habitual para muchos equipos de LaLiga).
- **Regla 70/30**: solo se aplica en la **configuración inicial** (sin partida guardada). Una vez empiezas, puedes vender/ceder libremente sin restricciones.
- **Inspector Isar**: en modo debug, abre `http://localhost:8080` para navegar por la BD.
- **Modo depuración**: `DebugDatabaseScreen` (visible solo en `kDebugMode` desde `TitleScreen`) permite inspeccionar jugadores, equipos y `GameSave`.
- **Reescalado**: las pantallas usan `Responsive.gridColumns` y `Responsive.maxContentWidth` para adaptarse a móvil, tablet, escritorio y Web. La tipografía respeta `MediaQuery.textScaler` con un tope del 130 %.
- **Privacidad / Local**: la base de datos Isar se almacena en el directorio de documentos de la app. No se comparte información con servicios externos durante la partida (la API solo se usa en la sincronización inicial).
- **Migraciones**: actualmente no se ha incluido lógica de migración. Si renombras campos Isar, debes regenerar los `.g.dart` y, si la BD ya existe, podría ser necesario borrarla o ejecutar `Isar.deleteFromStorage()`.
- **Planificación multiplayer**: el código no soporta partidas en red; todo es local.
- **Icono**: el logo `PcFutbol26.png` debe existir en `assets/icons/`. Está empaquetado en el repo.

---

## 13. Estructura detallada del proyecto

```
pc_futbol_2026/
├── android/                       # Proyecto Android
├── ios/                           # Proyecto iOS
├── macos/                         # Proyecto macOS
├── windows/                       # Proyecto Windows
├── linux/                         # Proyecto Linux
├── web/                           # Proyecto Web
├── assets/
│   ├── .env                       # Clave API-Football
│   ├── data/
│   │   └── players.json           # Dataset de jugadores (fallback)
│   └── icons/
│       └── PcFutbol26.png         # Icono de la app
├── lib/
│   ├── main.dart                  # Entry point + tema
│   ├── core/                      # 32 servicios
│   │   ├── api_service.dart
│   │   ├── board_service.dart
│   │   ├── calendar_service.dart
│   │   ├── cup_service.dart
│   │   ├── database_service.dart
│   │   ├── editor_service.dart
│   │   ├── finance_service.dart
│   │   ├── financial_guard_service.dart
│   │   ├── game_calendar.dart
│   │   ├── game_engine.dart
│   │   ├── game_session_service.dart
│   │   ├── international_scout_service.dart
│   │   ├── league_service.dart
│   │   ├── lineup_guard.dart
│   │   ├── lineup_service.dart
│   │   ├── loan_service.dart
│   │   ├── match_discipline_service.dart
│   │   ├── match_engine.dart
│   │   ├── message_service.dart
│   │   ├── pc_futbol_colors.dart
│   │   ├── player_generator.dart
│   │   ├── player_progression_service.dart
│   │   ├── press_service.dart
│   │   ├── responsive.dart
│   │   ├── scout_service.dart
│   │   ├── squad_service.dart
│   │   ├── staff_generator.dart
│   │   ├── staff_service.dart
│   │   ├── tactics_service.dart
│   │   ├── training_engine.dart
│   │   ├── transfer_ai_service.dart
│   │   ├── transfer_manager_service.dart
│   │   └── youth_service.dart
│   ├── models/                    # 12 entidades Isar (+ .g.dart) y 2 DTOs
│   │   ├── player_model.dart
│   │   ├── team.dart
│   │   ├── game_save.dart
│   │   ├── league_fixture.dart
│   │   ├── cup_fixture.dart
│   │   ├── league_standing.dart
│   │   ├── transfer_offer.dart
│   │   ├── finance_model.dart
│   │   ├── user_lineup.dart
│   │   ├── game_message.dart
│   │   ├── match_event.dart
│   │   ├── match_stats.dart
│   │   ├── staff.dart
│   │   ├── staff_member.dart
│   │   ├── sponsor.dart
│   │   └── editor_config.dart
│   ├── screens/                   # 26 pantallas
│   │   ├── splash_screen.dart
│   │   ├── title_screen.dart
│   │   ├── team_selection_screen.dart
│   │   ├── main_menu_screen.dart
│   │   ├── squad_screen.dart
│   │   ├── player_detail_screen.dart
│   │   ├── player_search_screen.dart
│   │   ├── lineup_screen.dart
│   │   ├── advanced_tactics_screen.dart
│   │   ├── training_screen.dart
│   │   ├── match_day_screen.dart
│   │   ├── transfer_market_screen.dart
│   │   ├── transfer_offers_screen.dart
│   │   ├── transfer_negotiation_screen.dart
│   │   ├── international_scout_screen.dart
│   │   ├── editor_screen.dart
│   │   ├── finance_screen.dart
│   │   ├── stadium_screen.dart
│   │   ├── staff_screen.dart
│   │   ├── full_calendar_screen.dart
│   │   ├── league_table_screen.dart
│   │   ├── club_management_screen.dart
│   │   ├── youth_academy_screen.dart
│   │   ├── trophy_room_screen.dart
│   │   ├── president_screen.dart
│   │   ├── secretary_screen.dart
│   │   └── debug_database_screen.dart
│   └── widgets/
│       ├── match_substitution_sheet.dart
│       └── radar_chart.dart
├── test/
├── gen_players.dart               # Script auxiliar de generación
├── pubspec.yaml                   # Dependencias
├── pubspec.lock
├── analysis_options.yaml
└── README.md
```

---

**PC Fútbol 2026 Edition** — Reconstruido con cariño para quienes crecieron eligiendo alineación los domingos a las seis.
