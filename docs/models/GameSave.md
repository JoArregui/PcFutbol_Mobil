# Modelo: GameSave (Partida Guardada)
Entidad Isar que almacena todo el estado de una partida en curso.

## Propiedades

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `id` | `Id` | ID fijo (siempre 1) |
| `userTeamApiId` | `int` | ID API del equipo del usuario |
| `currentMatchday` | `int` | Jornada actual (1-38) |
| `totalMatchdays` | `int` | Jornadas totales (default 38) |
| `staffSecretaryName` | `String` | Nombre del secretario |
| `staffSecretaryLevel` | `int` | Nivel del secretario |
| `staffPreparatorName` | `String` | Nombre del preparador físico |
| `staffPreparatorLevel` | `int` | Nivel del preparador físico |
| `staffMedicoName` | `String` | Nombre del médico |
| `staffMedicoLevel` | `int` | Nivel del médico |
| `seasonFinished` | `bool` | True si la temporada ha terminado |
| `seasonNumber` | `int` | Número de temporada (1 = primera) |
| `inCup` | `bool` | True si el usuario sigue en Copa del Rey |
| `cupRound` | `int` | Ronda actual de Copa (1-4) |
| `trophies` | `List<String>` | Trofeos conseguidos |
| `matchMode` | `String` | Modo de partido: 'resumen' o 'resultado' |
| `consecutiveRedWeeks` | `int` | Semanas consecutivas en rojo (despido a las 3) |
| `financiallyDismissed` | `bool` | Despedido por números rojos |
| `boardObjectiveMaxPosition` | `int` | Máxima posición objetivo (4 = top 4, 17 = salvación) |
| `boardObjectiveLabel` | `String` | Etiqueta textual del objetivo |
| `internationalScoutsUsed` | `int` | Scouts internacionales usados esta temporada |
| `currentDay` | `int` | Día dentro de la semana (1-7) |
| `boardAcceptance` | `int` | Confianza de la directiva (0-100) |
| `boardLastFeedback` | `String` | Último feedback del presidente |
| `lineupGeneratedPlayers` | `int` | Histórico de jugadores generados en convocatorias |
| `lineupTotalPlayers` | `int` | Histórico total de jugadores en convocatorias |
| `trainingFocusesUsedToday` | `List<String>` | Focos de entrenamiento usados hoy |
| `teamMentality` | `TeamMentality` | Mentalidad del equipo |
| `teamIntensity` | `TeamIntensity` | Intensidad del equipo |
| `teamStyle` | `TeamStyle` | Estilo de juego |
| `phasePlans` | `List<String>` | Planes de partido por fases |
| `defaultFormation` | `String` | Formación por defecto |
| `useAutomaticPhaseAdjustments` | `bool` | Usar ajustes automáticos por fase |
| `boardRequirements` | `List<BoardRequirement>` | Requerimientos específicos de la directiva |
| `lastFanSurvey` | `FanSurvey?` | Última encuesta a la afición |
| `lastSurveyDate` | `DateTime?` | Fecha de la última encuesta |
| `derbiesWon` | `int` | Derbis ganados esta temporada |
| `cleanSheets` | `int` | Porterías a cero esta temporada |
| `fanFavoritePlayerId` | `String?` | Jugador favorito de la afición |

## Enumeraciones

### `GamePhasePlan`
Planes por fases para ajustes automáticos durante el partido:
- `early`: 0-30 min
- `mid`: 31-60 min
- `late`: 61-75 min
- `veryLate`: 76-90 min
- `ifWinning`: Si vamos ganando
- `ifLosing`: Si vamos perdiendo
- `ifDrawing`: Si vamos empatando

### `BoardRequirementType`
Tipos de requerimientos de la directiva:
- `signPlayer`: Fichar un jugador específico
- `promoteYouth`: Promover canteranos
- `reachPosition`: Alcanzar posición en jornada X
- `winDerby`: Ganar el derbi
- `keepCleanSheets`: Mantener X porterías a cero
- `scoreGoals`: Marcar X goles
- `developPlayer`: Mejorar un jugador

## Objetos Embebidos

### `BoardRequirement`
Requerimiento específico de la directiva.

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `type` | `BoardRequirementType` | Tipo de requerimiento |
| `description` | `String` | Descripción |
| `targetValue` | `int` | Valor objetivo |
| `currentValue` | `int` | Valor actual |
| `completed` | `bool` | True si completado |
| `deadline` | `DateTime?` | Fecha límite |
| `playerId` | `String?` | ID del jugador (si aplica) |

### `FanSurvey`
Resultado de encuesta a la afición.

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `approvalRating` | `int` | Aprobación (0-100) |
| `favoritePlayer` | `String` | Jugador favorito |
| `mostCriticizedPlayer` | `String` | Jugador más criticado |
| `feedback` | `String` | Comentarios |
| `surveyDate` | `DateTime` | Fecha de la encuesta |
