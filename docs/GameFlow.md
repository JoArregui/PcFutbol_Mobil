# Flujo de Juego

## 1. Inicio y Configuración

### Paso 1.1: Pantalla de Inicio (Splash)
Se inicia la app, se carga el entorno, y se muestra la pantalla de splash.

### Paso 1.2: Pantalla de Título (TitleScreen)
El usuario elige entre:
- **Nueva Partida**: Empezar una temporada nueva
- **Continuar Partida**: Si hay una partida guardada, la carga

### Paso 1.3: Selección de Equipo (TeamSelectionScreen)
El usuario elige su equipo de LaLiga 2024-2026.
- Se muestra info de cada equipo (presupuesto, tier, expectativas)
- Al confirmar, se crea `GameSave` inicial

### Paso 1.4: Contratar Cuerpo Técnico
El usuario elige secretario, preparador físico y médico, cada uno con su nivel.

---

## 2. Menú Principal (Despacho)
Desde aquí accedes a todas las funcionalidades del juego:

| Icono | Pantalla | Descripción |
|-------|----------|-------------|
| 📋 | SquadScreen | Ver y gestionar la plantilla |
| 📝 | LineupScreen | Configurar alineación y táctica |
| 🏋️ | TrainingScreen | Entrenar a los jugadores |
| 📊 | LeagueTableScreen | Ver clasificación de la liga |
| ⚽ | PlayerSearchScreen | Mercado de fichajes |
| 💼 | TransferOffersScreen | Gestionar ofertas de traspaso |
| 🌍 | InternationalScoutScreen | Ojeador internacional |
| 🎨 | EditorScreen | Editor de liga y plantillas |
| 💰 | FinanceScreen | Finanzas del club |
| 🏟️ | StadiumScreen | Gestión del estadio |
| 👔 | StaffScreen | Mejorar cuerpo técnico |
| 🗓️ | FullCalendarScreen | Ver calendario completo |
| 🏢 | ClubManagementScreen | Gestión del club y cantera |
| 🏠 | YouthAcademyScreen | Cantera juvenil |
| 🎯 | PresidentScreen | Presidente y objetivos |
| ✉️ | SecretaryScreen | Mensajes y noticias |
| 🏆 | TrophyRoomScreen | Sala de trofeos |

---

## 3. Día de Partido

### Paso 3.1: Llegar al partido
Cuando el `currentDay` es 7 (día del partido), se activa la opción de jugar.

### Paso 3.2: Configurar alineación final
Ajustes de última hora en la alineación y táctica.

### Paso 3.3: Simular partido
- **Modo Resumen**: Minuto a minuto con eventos importantes
- **Modo Resultado**: Simulación instantánea

### Paso 3.4: Post-partido
1. Ver **Hoja de Partido** (MatchStats) con:
   - Goles, tarjetas
   - Estadísticas por jugador (notas)
   - Man of the Match
2. Leer **Nota de Prensa** (PressService)
3. Se actualiza la clasificación
4. Se actualizan las finanzas
5. Se avanza de jornada o a la ronda de Copa

---

## 4. Ciclo de la Temporada

### Semana Normal
1. Días 1-6: Entrenar, gestionar plantilla, mercado
2. Día 7: Partido de liga

### Doble Jornada (Copa del Rey)
En jornadas 6, 18, 30 y 38, después del partido de liga, hay partido de Copa del Rey:
1. Jugar partido de liga
2. Jugar partido de Copa (si sigues en el torneo)
3. Avanzar de jornada

### Fin de Temporada
1. Después de la jornada 38: Se calcula la clasificación final
2. El presidente evalúa tu rendimiento
3. Se decide si continuas o no
4. Opción de empezar **Temporada 2** con el mismo equipo

---

## 5. Entrenamiento
### Funcionamiento
- No puedes usar el mismo foco de entrenamiento dos veces en el mismo día
- El entrenamiento automático elige foco y jugadores ideales
- Los unicornios (talentos excepcionales) ganan atributos más rápido

### Focos de entrenamiento
| Foco | Mejora |
|------|--------|
| Físico | Velocidad y físico |
| Tiro | Definición y precisión |
| Pase | Visión de juego y control |
| Defensa | Posicionamiento y robo de balón |
| Táctica | Equilibrio general del equipo |

---

## 6. Despedida
- Si pasas 3 semanas consecutivas en rojo (finanzas)
- Si no cumples los objetivos de la directiva
- En ambos casos, te despiden y la partida termina
