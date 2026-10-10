# Ingenieria-lasCuatrillizas

# Papa Caliente

Juego de terror 3D con cámara fija (vista lateral y vista trasera). Motor: **Godot 4.7** (GDScript).

## Cómo correrlo
1. Instalar Godot 4.7.
2. Importar la carpeta (archivo `project.godot`) y dar Play (F5).
3. Controles: `A/D` mover · `W/S` avanzar/retroceder (vista trasera) · `E` interactuar/avanzar diálogo · `Shift` correr y `Espacio` saltar (solo en la persecución).

## Estructura
```
assets/     modelos, audio y UI (ver assets/README.md para convenciones de Blender)
scenes/     main, player, camera, ui y levels/ (10 niveles)
scripts/    autoload/ core/ player/ camera/ interaction/ levels/ dialogue/ minigames/ enemies/ ui/
data/       dialogues/*.json
docs/       ESCENARIOS.md (guion -> niveles, estado y pendientes)
AI_TRACE.md registro de uso de IA (solo agregar entradas)
```


## Trazabilidad del desarrollo

El registro detallado (entrada por entrada) está en [`AI_TRACE.md`](AI_TRACE.md). Resumen:

**Punto de partida.** Repositorio vacío (commit inicial) y un guion de juego escrito por el equipo ("Papa Caliente"). [COMPLETAR DESDE GIT: fecha y hash del commit inicial]

**Hitos principales (orden cronológico).**
1. Lectura del guion y decisiones de diseño: juego 3D de cámara fija, estilo oscuro tipo Blasphemous; la escena de los latigazos no se representa de forma explícita.
2. Esqueleto del proyecto en Godot (carpetas de assets, movimiento, cámara, interacción, diálogos, cambio de nivel, 10 niveles base). [COMPLETAR DESDE GIT: commit]
3. Escenarios 3D modelados en Blender y exportados a `.glb`; integrados a los 10 niveles con colisiones, rampas, spawns y diálogos del guion. [COMPLETAR DESDE GIT: commit]
4. Correcciones tras probar en Godot 4.7: tipo de una variable, conversión de luces y avance de diálogos. [COMPLETAR DESDE GIT: commits]

**Herramientas de IA utilizadas.** Claude (código del juego, integración de escenarios y depuración; modelado de escenarios en Blender mediante el MCP de Blender). El equipo también planea usar ChatGPT y Gemini; aún no han quedado registrados en `AI_TRACE.md`.

**Assets externos.** Texturas PBR de Poly Haven y assets de Kenney [COMPLETAR: cuáles]. Revisar la licencia de cada uno antes de la entrega.

**Ejemplos de tareas donde la IA fue relevante.**
- Generar el esqueleto del proyecto y la estructura de niveles (Entrada 001).
- Generar con el MCP de Blender los escenarios 1, 2, 4, 5A, 5B, 6 y 7 (Entradas 004 a 009).
- Integrar los `.glb` al juego leyendo sus medidas y marcadores (Entrada 011).
- Diagnosticar la sobreexposición de luces y el bloqueo de diálogos (Entradas 012 y 013).

**Intervenciones humanas importantes.**
- El equipo escribió el guion y decidió la dirección artística y el formato 3D.
- El equipo eligió y confirmó Godot 4.7, abrió y probó el proyecto, y reportó cada error con capturas de pantalla.
- Los escenarios se revisaron y se ajustaron los colores a mano; los `.glb` los exportó el equipo desde Blender.
- El equipo gestiona los commits, las ramas (`devAlejandro`) y el flujo con el resto del grupo.

**Limitaciones y pendientes.**
- Los personajes (Malaes, Lilith, monja, Papa) son placeholders sin modelo ni animaciones.
- Falta pulir la cámara, las paredes invisibles, la escalera de la galería y varios eventos (transformación de Lilith, Papa en fuego, animaciones de puertas).
- La persecución y el resto de niveles están pendientes de prueba completa en el motor.
- Los `.blend` y las texturas pesan unos 600 MB; falta decidir cómo subirlos (Git LFS, texturas más pequeñas o almacenamiento externo).
- [COMPLETAR DESDE GIT: hashes, fechas y commits finales]
