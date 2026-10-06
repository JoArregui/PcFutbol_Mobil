# Servicio: PressService (Prensa Post-Partido)
Genera notas de prensa estilo PC Fútbol 7 después de cada partido.

## Métodos

### `PressService(this.isar)`
Constructor.

### `static `
Placeholders para compatibilidad
- `publishMatchReaction` y `publishTransferNews`
Métodos vacíos para mantener compatibilidad con otras partes del código que aún los invocaban versiones anteriores de este servicio.

### `static String generateMatchReport({...})`
Genera un reporte de prensa completo después de cada partido.

**Parámetros**:
- `teamName`: Nombre de tu equipo
- `opponentName`: Nombre del rival
- `ourGoals`: Goles de tu equipo
- `theirGoals`: Goles del rival
- `stats`: Objeto FullMatchStats con todas las estadísticas
- `wasHome`: true si jugaste en casa

**Estructura del reporte**:
1. Título con el marcador final
2. Párrafo principal con el contexto del resultado
3. Evento clave (tarjetas, córners, goles
4. Jugador destacado (Man of the Match
5. Conclusión aleatoria

**Ejemplo de salida**:
```
📰 PRENSA POST-PARTIDO

**🏠 Real Madrid 3 - 1 Barcelona

«🎉 Victoria Real Madrid ha conseguido una victoria importante ante un rival directo

💥 Partido con mucho contacto: 6 tarjetas amarillas en total.

⭐ Vinicius Junior ha sido el mejor del partido con una nota de 9.3.

Tres puntos muy importantes para los objetivos de la temporada.
```

### `String _getResultString(int ourGoals, int theirGoals)`
Devuelve la cadena con el tipo de resultado (Victoria/Empate/Derrota) + emoji)

### `String _getOpeningSentence(int ourGoals, int theirGoals, bool wasHome)`
Devuelve una oración de apertura aleatoria según el resultado.

### `String _getKeyEvent(FullMatchStats stats, int ourGoals, int theirGoals)`
Detecta el evento clave del partido (muchas tarjetas, muchos córners o goles, etc.)

### `String _getConclusion(int ourGoals, int theirGoals, String teamName)`
Devuelve una frase de cierre aleatoria según el resultado.
