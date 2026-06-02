# PC Fútbol 2026

Homenaje al simulador de gestión **PC Fútbol 7**, desarrollado en Flutter.

## Requisitos

- Flutter SDK ≥ 3.0
- Clave de [API-Football](https://www.api-football.com/) (plan gratuito válido para pruebas)

## Configuración

1. Crea el archivo `assets/.env`:

```env
FOOTBALL_API_KEY=tu_clave_aqui
```

2. Instala dependencias y genera código Isar:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

3. Ejecuta la app:

```bash
flutter run
```

## Cómo jugar

1. **Nueva partida** → Elige equipo de LaLiga → Contrata cuerpo técnico.
2. **Menú (despacho)** → Plantilla, alineación y táctica, entreno, mercado (fichajes y ventas), finanzas, estadio (vallas y ampliación), club (cantera, secretaría, trofeos), clasificación, mensajes.
3. **Modo de partido** → Toca el chip *PARTIDO: RESUMEN/RESULTADO* (como en PC Fútbol 7).
4. **Liga y Copa** → *Siguiente partido* para la liga; en jornadas 6, 18, 30 y 38 aparece la Copa del Rey si sigues en el torneo.
5. **Temporadas** → Al finalizar la liga puedes iniciar una **nueva temporada** con el mismo club.
6. **Jornada doble** → Copa y liga el mismo día (jornadas 6, 18, 30, 38): juega ambos partidos antes de avanzar.
7. **Ofertas / Ojeador / Editor** → Mercado con IA, scouting internacional y editor de liga y plantilla.
8. **Prensa y presidente** → Prensa en mensajes (filtro); despido tras 3 semanas en rojo; objetivos del consejo.

## Estructura

- `lib/core/` — API, liga, partido, finanzas, alineación, mensajes
- `lib/models/` — Isar (jugadores, equipos, fixtures, clasificación, partida)
- `lib/screens/` — UI del juego

## Notas

- La primera sincronización descarga equipos y plantillas de LaLiga (liga 140). Consume cuota de API.
- Los datos de valor/estadísticas de jugadores son estimados cuando la API no los proporciona.
