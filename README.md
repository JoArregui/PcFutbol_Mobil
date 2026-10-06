# PC Fútbol 2026

> Un tributo al clásico simulador de gestión futbolística **PC Fútbol 7**, desarrollado completamente en Flutter.

---

## 🏟️ Características Principales

### 🔹 Gestión Completa del Equipo
- **Plantilla**: Administra tus jugadores, valora su nivel y potencial.
- **Alineación y Táctica**: Elige tu 11 ideal, ajusta la táctica (formación, mentalidad, intensidad y estilo).
- **Entrenamiento**: Mejora las habilidades de tus jugadores con entrenamientos individuales o automáticos.
- **Mercado de Fichajes**: Compra, vende y préstamos jugadores con una IA realista.
- **Cantera**: Scout internacional y juveniles para el futuro.

### 🔹 Competiciones
- **LaLiga**: Temporada completa de liga de 38 jornadas.
- **Copa del Rey**: Torneo eliminatorio paralelo a la liga (jornadas 6, 18, 30 y 38).
- **Estadísticas de Partidos**: Hoja de partido detallada tras cada encuentro.
- **Prensa**: Notas de prensa post-partido con comentarios.

### 🔹 Dinámica del Juego
- **Modos de Partido**:
  - `RESUMEN`: Relato minuto a minuto con eventos importantes.
  - `RESULTADO`: Simulación instantánea del partido (estilo clásico).
- **Regla 70/30 inicial**: Al elegir equipo, la plantilla tiene como mínimo 70% de jugadores reales de la API.
- **Finanzas y Estadio**: Gestiona el presupuesto, precio de entradas, vallas publicitarias y expansión.
- **Presidente y Directiva**: Objetivos por temporada, confianza en el entrenador y riesgo de despido.

---

## 🛠️ Configuración del Proyecto

### Requisitos Técnicos
- Flutter SDK ≥ 3.0 (descargar desde [flutter.dev](https://flutter.dev/))
- Clave API gratuita de [API-Football](https://www.api-football.com/)
- Dispositivo o emulador Android/iOS, o Chrome para web

### 1. Configurar Variables de Entorno
Crea el archivo `assets/.env` en la raíz del proyecto:

```env
# Clave API de API-Football
FOOTBALL_API_KEY=TU_CLAVE_AQUI
```

### 2. Instalar Dependencias
Ejecuta en la terminal:
```bash
flutter pub get
```

### 3. Generar Código de Isar
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Ejecutar la App
```bash
# En modo debug
flutter run

# Para crear un APK de release
flutter build apk --release
```

---

## 📂 Estructura del Proyecto

```
pcfutbol_2026/
├── assets/                     # Recursos del juego
│   ├── .env                   # Variables de entorno
│   └── data/players.json      # Datos de jugadores (fallback)
├── lib/                        # Código fuente principal
│   ├── core/                  # Servicios y lógica de negocio
│   │   ├── api_service.dart   # Conexión con API-Football
│   │   ├── board_service.dart # Interacción con la directiva
│   │   ├── calendar_service.dart # Calendario de competiciones
│   │   ├── cup_service.dart   # Logica de la Copa del Rey
│   │   ├── database_service.dart # Acceso a la BD Isar
│   │   ├── editor_service.dart # Editor de liga y plantilla
│   │   ├── finance_service.dart # Gestion de finanzas
│   │   ├── financial_guard_service.dart # Control financiero
│   │   ├── game_calendar.dart # Gestión de dias y jornadas
│   │   ├── game_engine.dart   # Motor de simulación de partidos
│   │   ├── game_session_service.dart # Estado de la partida
│   │   ├── international_scout_service.dart # Ojeador internacional
│   │   ├── league_service.dart # Logica de la liga
│   │   ├── lineup_guard.dart  # Validador de alineación
│   │   ├── lineup_service.dart # Servicio de alineación
│   │   ├── loan_service.dart  # Gestión de préstamos
│   │   ├── match_discipline_service.dart # Tarjetas y sanciones
│   │   ├── match_engine.dart  # Motor de partido
│   │   ├── match_stats.dart   # Estadísticas de partido
│   │   ├── message_service.dart # Mensajes y noticias
│   │   ├── player_generator.dart # Generador de jugadores ficticios
│   │   ├── player_progression_service.dart # Progreso y edad
│   │   ├── press_service.dart  # Notas de prensa
│   │   ├── pc_futbol_colors.dart # Colores del juego
│   │   ├── responsive.dart    # Ajustes responsive
│   │   ├── squad_service.dart # Servicio de plantillas
│   │   ├── staff_generator.dart # Generador de cuerpo técnico
│   │   ├── staff_service.dart # Servicio de staff
│   │   ├── tactics_service.dart # Logica táctica
│   │   ├── training_engine.dart # Motor de entrenamiento
│   │   ├── transfer_ai_service.dart # IA del mercado
│   │   └── youth_service.dart # Cantera y juveniles
│   ├── models/                # Entidades y modelos Isar
│   │   ├── cup_fixture.dart   # Partidos de Copa
│   │   ├── editor_config.dart # Configuración del editor
│   │   ├── finance_model.dart # Finanzas del club
│   │   ├── game_message.dart  # Mensajes del juego
│   │   ├── game_save.dart     # Estado de la partida guardada
│   │   ├── league_fixture.dart # Partidos de Liga
│   │   ├── league_standing.dart # Clasificación de la liga
│   │   ├── match_event.dart   # Eventos de partido
│   │   ├── match_stats.dart   # Estadísticas de partido
│   │   ├── player_model.dart  # Entidad Jugador
│   │   ├── sponsor.dart       # Patrocinadores
│   │   ├── staff.dart         # Cuerpo técnico
│   │   ├── team.dart          # Entidad Equipo
│   │   ├── transfer_offer.dart # Ofertas de traspaso
│   │   └── user_lineup.dart   # Alineación del usuario
│   ├── screens/               # Pantallas de la app
│   │   ├── title_screen.dart  # Pantalla de inicio
│   │   ├── team_selection_screen.dart # Selección de equipo
│   │   ├── main_menu_screen.dart # Menú principal (despacho)
│   │   ├── squad_screen.dart  # Pantalla de plantilla
│   │   ├── lineup_screen.dart # Pantalla de alineación
│   │   ├── training_screen.dart # Entrenamiento
│   │   ├── finance_screen.dart # Finanzas
│   │   ├── stadium_screen.dart # Estadio
│   │   ├── staff_screen.dart  # Cuerpo técnico
│   │   ├── player_search_screen.dart # Búsqueda de jugadores
│   │   ├── transfer_offers_screen.dart # Ofertas de traspaso
│   │   ├── league_table_screen.dart # Clasificación de la liga
│   │   ├── full_calendar_screen.dart # Calendario completo
│   │   ├── president_screen.dart # Presidente y directiva
│   │   ├── secretary_screen.dart # Secretaría y mensajes
│   │   ├── club_management_screen.dart # Gestión del club
│   │   ├── youth_academy_screen.dart # Cantera
│   │   ├── international_scout_screen.dart # Ojeador
│   │   ├── match_day_screen.dart # Día de partido
│   │   ├── player_detail_screen.dart # Detalle de jugador
│   │   ├── editor_screen.dart # Editor
│   │   ├── debug_database_screen.dart # Debug BD
│   │   └── trophy_room_screen.dart # Sala de trofeos
│   ├── widgets/               # Widgets reutilizables
│   │   ├── match_substitution_sheet.dart # Panel de sustituciones
│   │   └── radar_chart.dart   # Gráfico radar
│   └── main.dart             # Punto de entrada
├── gen_players.dart          # Script generador de jugadores
└── pubspec.yaml             # Dependencias y configuración
```

---

## 🎮 Cómo Jugar

### Paso 1: Inicio y Selección de Equipo
1. Arranca la app.
2. Elige entre **Nueva Partida** o **Continuar Partida** (si hay una guardada).
3. Selecciona tu equipo de LaLiga 2024-2026.
4. Contrata tu cuerpo técnico (secretario, preparador físico y médico).

### Paso 2: El Despacho (Menú Principal)
Desde aquí tienes acceso a todas las áreas:
- 📋 **Plantilla**: Gestiona tus jugadores, revisa su condición física y edad.
- 📝 **Alineación**: Pon a tu 11 ideal y define la táctica.
- 🏋️ **Entrenamiento**: Mejora las habilidades de los jugadores. No puedes repetir el mismo foco en el mismo día!
- 📊 **Clasificación**: Mira la tabla de la liga.
- ⚽ **Mercado**: Busca y ficha nuevos jugadores, vende o presta los tuyos.
- 💼 **Ofertas**: Gestiona las ofertas de traspaso que te llegan.
- 🌍 **Ojeador**: Busca talento internacional.
- 🎨 **Editor**: Edita liga y plantillas al gusto.
- 💰 **Finanzas**: Controla el presupuesto del club.
- 🏟️ **Estadio**: Ajusta el precio de las entradas y amplía la capacidad.
- 👔 **Staff**: Mejora tu cuerpo técnico.
- 🗓️ **Calendario**: Ver todos los partidos de la temporada.
- 🏢 **Club**: Gestiona la cantera, la secretaría y tus trofeos.
- 🎯 **Presidente**: Consulta los objetivos y la confianza de la directiva.
- ✉️ **Mensajes**: Lee las noticias de prensa, comunicados y ofertas.

### Paso 3: Día de Partido
1. Cuando llegue el día del partido, verás el chip "JUGAR PARTIDO".
2. Configura tu alineación y táctica final.
3. Elige entre modo **RESUMEN** (minuto a minuto) o **RESULTADO** (inmediato).
4. Disfruta del partido y ve el marcador en directo!
5. Después del partido, revisa la **Hoja de Partido** y las **Notas de Prensa**.

### Paso 4: La Temporada
- Completa las 38 jornadas de liga y las eliminatorias de Copa del Rey.
- En **jornadas 6, 18, 30 y 38** habrá doble jornada (liga + Copa).
- Al finalizar la temporada, podrás **comenzar la siguiente temporada** con el mismo club.
- ¡Cuidado con los números rojos! 3 semanas consecutivas en rojo y serás despedido.

---

## 💾 Almacenamiento de Datos (Isar)
El proyecto usa **Isar Database**, una base de datos NoSQL rápida y ligera para Flutter, para almacenar:
- Partidas guardadas (`GameSave`)
- Jugadores (`Player`)
- Equipos (`Team`)
- Partidos (`LeagueFixture`, `CupFixture`)
- Clasificación (`LeagueStanding`)
- Finanzas (`ClubFinance`)
- Mensajes (`GameMessage`)
- Ofertas (`TransferOffer`)

---

## 🔌 API-Football
Los datos reales de equipos y jugadores vienen de [API-Football](https://www.api-football.com/).
- La primera vez que abres la app, se descarga automáticamente la lista de equipos de LaLiga (ID 140) y sus plantillas.
- Cuando el usuario selecciona un equipo para su nueva partida, se asegura la regla 70/30: ≥70% de jugadores reales, ≤30% generados localmente.
- En temporadas siguientes, ya no se consulta la API, solo se usan los datos locales.

---

## 🤝 Contribuciones
¡Las contribuciones son bienvenidas! Si quieres aportar:
1. Haz un fork del repositorio.
2. Crea una rama (`git checkout -b feature/nueva-funcionalidad`).
3. Haz commit de tus cambios (`git commit -m 'Añadir nueva funcionalidad'`).
4. Push a la rama (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

---

## 📜 Licencia
Este proyecto es un tributo a PC Fútbol 7, de uso educativo y entretenimiento sin ánimo de lucro.
