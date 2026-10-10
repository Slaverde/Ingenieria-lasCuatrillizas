# AI_TRACE

Registro incremental del uso de IA en el desarrollo. **Solo se agregan entradas nuevas al final; no se reescriben las anteriores.**

- EVENT_ID: [COMPLETAR]
- TEAM_ID: [COMPLETAR]
- Repositorio: Ingenieria-lasCuatrillizas
- Herramientas de IA del equipo: Claude, ChatGPT, Gemini (en la Entrada 001 solo se usó Claude; cada entrada nueva indica cuál herramienta se usó)
- Motor: Godot 4.3 (GDScript) — escogido por la IA como supuesto, **pendiente de confirmar por el equipo**

---

## Entrada 001 — 2026-10-10 (America/Bogota)
- PARTICIPANT_ID: [COMPLETAR] (Alejandro)
- Herramienta de IA: Claude
- ACTION_TYPE: AI_GENERATED
- Tarea: esqueleto inicial del proyecto "Papa Caliente".
- Archivos: `project.godot`, `.gitignore`, `.gitattributes`, `assets/README.md`, `docs/ESCENARIOS.md`, `scripts/**` (autoloads, player, camera, interaction, levels, dialogue, minigames, enemies, ui), `scenes/**` (main, player, camera_rig, hud, 10 niveles), `data/dialogues/*.json`.
- Resumen: estructura de carpetas para assets de Blender y codigo; movimiento del jugador en vista lateral y trasera; camara fija de dos modos; sistema de interaccion y dialogos; cambio de nivel con fundido; 10 niveles vacios conectados segun el guion; Escenario 1 jugable (carta) y dialogo de Lilith del Escenario 2.
- Limitaciones: **no se pudo ejecutar Godot en el entorno de la IA, el codigo NO esta probado**; las escenas `.tscn` fueron escritas a mano y podrian requerir correcciones al abrirse en el editor. Todos los visuales son placeholders. Se asumio Godot 4.3.
