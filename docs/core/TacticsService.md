# Servicio: TacticsService (Gestión de Táctica)
Ofrece funcionalidades para la gestión de táctica del equipo: formaciones, mentalidad, intensidad y estilo.

## Enumeraciones

### `TeamMentality`
Mentalidad del equipo durante el partido.

| Valor | Descripción |
|-------|-------------|
| `veryDefensive` | Ultra-defensiva — cerrar shop |
| `defensive` | Defensiva — priorizar no encajar |
| `balanced` | Equilibrada — peso igual en ambos |
| `attacking` | Ofensiva — ir a por el partido |
| `veryAttacking` | Todo al ataque — riesgo alto |

### `TeamIntensity`
Intensidad física del equipo.

| Valor | Descripción |
|-------|-------------|
| `low` | Baja — conservar energía |
| `normal` | Normal — ritmo clásico |
| `high` | Alta — presionar mucho |
| `veryHigh` | Muy alta — presión total |

### `TeamStyle`
Estilo de juego.

| Valor | Descripción |
|-------|-------------|
| `possession` | Toque — mantener el balón |
| `direct` | Directo — buscar rápido al delantero |
| `counterAttack` | Contraataque — aprovechar espacios |
| `longBall` | Balón largo — al área directamente |

## Formaciones Disponibles

```dart
static const formations = [
  '4-4-2',
  '4-3-3',
  '3-5-2',
  '5-3-2',
  '4-2-3-1',
  '4-5-1'
];
```

## Métodos

### `String formationLabel(String formation)`
Devuelve una descripción textual de la formación.

**Ejemplos**:
- '4-3-3' → 'Ofensiva — más llegada al área'
- '4-4-2' → 'Clásica — equilibrio total'

### `String mentalityLabel(TeamMentality mentality)`
Devuelve una descripción de la mentalidad.

### `String intensityLabel(TeamIntensity intensity)`
Devuelve una descripción de la intensidad.

### `String styleLabel(TeamStyle style)`
Devuelve una descripción del estilo.

### `({double attack, double defense, double possession, double energy}) fullModifiers({...})`
Calcula los multiplicadores completos de la táctica para el motor de partido.

**Parámetros**:
- `formation`: Formación a usar
- `mentality`: Mentalidad
- `intensity`: Intensidad
- `style`: Estilo de juego

**Devuelve**:
- `attack`: Multiplicador de ataque
- `defense`: Multiplicador de defensa
- `possession`: Multiplicador de posesión
- `energy`: Consumo energético

**Ejemplo de uso**:
```dart
final mods = TacticsService.fullModifiers(
  formation: '4-3-3',
  mentality: TeamMentality.attacking,
  intensity: TeamIntensity.high,
  style: TeamStyle.possession,
);

print('Ataque: ${mods.attack}');
```
