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

---

# Entradas aportadas por la sesión de escenarios 3D (MCP de Blender)

Origen: resumen de la sesión de Claude conectada a Blender mediante el MCP de Blender (Python/bpy). Fecha de sesión: 2026-10-10; horas exactas: OBTENER DESDE GIT. PARTICIPANT_ID: [COMPLETAR]. En esa sesión no se hizo ningún commit ni push, no se importaron modelos 3D externos (todo es geometría procedural) y los renders de revisión se hicieron en EEVEE. Las texturas PBR vienen de Poly Haven (CC0). Todos los escenarios son placeholders de arte, sin personajes y sin probar en el motor.

## Entrada 002 — Lectura del guion y lore
- Herramienta de IA: Claude
- ACTION_TYPE: DESIGN
- Tarea: lectura del guion "Papa Caliente.docx" (solo lectura, sin modificar).
- Resumen: se resumió el guion por escenarios y se señalaron huecos (frase cortada en el altar, vistas no especificadas en los escenarios 6 y 7). No se generó ningún archivo.
- Decisión humana: no representar visualmente la escena de los latigazos tal como estaba escrita (menor desnudo); se omite su representación explícita.

## Entrada 003 — Decisión de dirección artística
- Herramienta de IA: ninguna (decisión humana del equipo)
- ACTION_TYPE: DESIGN
- Decisión: el juego es 3D, con estilo oscuro y serio tipo Blasphemous. Reemplaza las vistas 2D del guion original. Cámara lateral en los escenarios 1 y 2; cámara detrás del personaje en el 6.

## Entrada 004 — Escenario 6 (capilla)
- Herramienta de IA: Claude (MCP de Blender)
- ACTION_TYPE: AI_GENERATED
- Archivos: Escenario6_Capilla.blend (escena Escenario6_Capilla)
- Resumen: capilla simétrica de 12 x 22 m con bóveda, columnas, altar, cuadro de Malaes abrazado por un demonio, ~200 velones, bancos, estandartes y una nota en el centro.
- Limitaciones: el cuadro es un placeholder dibujado por código; materiales de color plano, sin texturas. Pendiente: arte final del cuadro.

## Entrada 005 — Escenario 1 (cuarto de Malaes)
- Herramienta de IA: Claude (MCP de Blender)
- ACTION_TYPE: AI_GENERATED
- Archivos: Escenario1_Cuarto.blend, Escenario6_Capilla.blend (escena Escenario1_Cuarto)
- Resumen: cuarto con cama, altar de rezo, cruz, látigo, puerta con pivote en la bisagra, carta y una vela como luz principal. Texturas Poly Haven (castle_wall_slates, stone_tiles_02, dark_wooden_planks, wood_planks), desaturadas. La cruz tiene el pivote en su centro para invertirla en el escenario 3.
- Limitaciones: se añadieron dos luces de relleno sin sombras para que se lea; pared frontal oculta para la cámara lateral.

## Entrada 006 — Escenario 2 (pasillo)
- Herramienta de IA: Claude (MCP de Blender)
- ACTION_TYPE: AI_GENERATED
- Archivos: Escenario2_Pasillo.blend, Escenario6_Capilla.blend (escena Escenario2_Pasillo)
- Resumen: pasillo de 36 m con 5 vitrales procedurales, 3 apliques de vela, la puerta del cuarto, la puerta del fondo, tapices, bancos y marcadores de gameplay.
- Limitaciones: los 4 materiales PBR compartidos pasaron de desplazamiento a bump para corregir una deformación; esto también afecta al escenario 1, que no se volvió a renderizar. Vitrales placeholder. Volumen de niebla creado pero desactivado.

## Entrada 007 — Escenario 4 (catacumbas)
- Herramienta de IA: Claude (MCP de Blender)
- ACTION_TYPE: AI_GENERATED
- Archivos: Escenario4_Catacumbas.blend, Escenario6_Capilla.blend (escena Escenario4_Catacumbas)
- Resumen: túnel de roca de 40 m con cámara detrás del personaje, biblioteca con la carta en latín, altar para rezar, puerta de los 3 santos con escaleras detrás, nichos con calaveras y antorchas. Texturas Poly Haven rock_wall y worn_tile_floor.
- Limitaciones: santos y calaveras son geometría simple (placeholder); marcadores para carta, altar y puerta.

## Entrada 008 — Escenario 5 (galería y persecución)
- Herramienta de IA: Claude (MCP de Blender)
- ACTION_TYPE: AI_GENERATED
- Archivos: Escenario5_Cripta.blend, Escenario6_Capilla.blend (escenas Escenario5A_Galeria y Escenario5B_Persecucion)
- Resumen: 5A es la galería lateral con escalera, cuatro cuadros, estatuas y la posición de Lilith. 5B es un túnel de 64 m con tres carriles y obstáculos, el escondite hacia la capilla y la puerta del Papa.
- Limitaciones: cuadros y estatuas placeholder; la distribución de obstáculos no se probó en el motor; iluminación del túnel subida para legibilidad.

## Entrada 009 — Escenario 7 (sala del Papa)
- Herramienta de IA: Claude (MCP de Blender)
- ACTION_TYPE: AI_GENERATED
- Archivos: Escenario7_SalaPapa.blend, Escenario6_Capilla.blend (escena Escenario7_SalaPapa)
- Resumen: nave de 30 x 60 x 22 m con columnas, arcos, presbiterio, altar, cruz gigante, rosetón rojo, dos colosos, pentagrama en el piso, braseros y marcadores.
- Limitaciones: tras el último render se movieron dos braseros que quedaban hundidos en las gradas, sin volver a renderizar. Estatuas de formas básicas reutilizadas. Faltan el Papa, la corona y el fuego, que deben hacerse en el motor. Iluminación baja a propósito.

## Estado reportado por la sesión de Blender (checkpoint parcial)
- Escenas en el .blend: 1, 2, 4, 5A, 5B, 6 y 7. El escenario 3 no tiene modelo nuevo: reutiliza el cuarto (cruz invertida) y el pasillo (puertas abiertas).
- Archivos creados en la carpeta local juegos2: Escenario1_Cuarto.blend, Escenario2_Pasillo.blend, Escenario4_Catacumbas.blend, Escenario5_Cripta.blend, Escenario6_Capilla.blend (contiene las siete escenas) y Escenario7_SalaPapa.blend. Aún no están en este repositorio.
- Nota de la sesión principal: esa sesión indicó "sin motor definido"; el motor quedó confirmado como Godot 4.7.
- Nota del equipo: los assets de estos escenarios están ajustados a nuestro código (convenciones de `assets/README.md` y estructura de niveles del proyecto). Indicado por el equipo; la verificación dentro de Godot 4.7 sigue pendiente.

---

## Entrada 010 — Corrección de tipo en `invisible_wall.gd`
- Herramienta de IA: Claude
- ACTION_TYPE: DEBUGGING
- Archivos: `scripts/levels/invisible_wall.gd`
- Resumen: Godot no podía deducir el tipo de la variable `open` (el valor venía de `get_flag`, de tipo variable); se le puso tipo explícito `bool`.
- Limitaciones: ninguna conocida; el proyecto corrió después del arreglo.
- Intervención humana: el equipo abrió el proyecto en Godot 4.7, reportó el error y comprobó que corre. El motor queda confirmado como Godot 4.7.

## Entrada 011 — Integración de los escenarios de Blender al juego
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scenes/levels/*.tscn` (10 niveles regenerados), `scripts/levels/level_base.gd`, `scripts/levels/level_01_cuarto.gd` … `level_10_sala_papa.gd` (nuevos o reescritos), `scripts/camera/camera_rig.gd`, `scripts/player/player.gd`, `scripts/enemies/lilith_chaser.gd`, `scripts/enemies/lilith_companion.gd`, `data/dialogues/*.json`, `docs/ESCENARIOS.md`, `assets/environments/*/*.glb` (movidos), `assets/blender_sources/*.blend` (movidos).
- Resumen: cada nivel carga su escenario `.glb`; se leyeron las medidas y marcadores de los `.glb` para fijar spawns, paredes, salidas e interactuables; se agregó soporte para colisiones por prefijo de nombre, rampas en escaleras, ocultar partes del modelo, quitar cámaras de Blender y ajustar luces; se conectó la historia de los escenarios 1 a 7 con diálogos del guion.
- Intervención humana: el equipo hizo los escenarios y exportó los `.glb` desde Blender, y los colocó en el proyecto.
- Limitaciones: **el código no se pudo ejecutar fuera de Godot; falta probarlo en el editor**. Anchos de paredes, rampas, cámara y luces son estimaciones a partir de las medidas de los modelos y habrá que afinarlas viendo cada nivel. Los personajes (Malaes, Lilith, monja, Papa) siguen siendo placeholders.

## Entrada 012 — Conversión de luces importadas desde Blender
- Herramienta de IA: Claude
- ACTION_TYPE: DEBUGGING
- Archivos: `scripts/levels/level_base.gd`, `docs/ESCENARIOS.md`
- Resumen: las luces de los `.glb` llegaban a Godot en candelas/lux (miles de unidades) y dejaban la escena completamente blanca. Se agregó una conversión automática (constantes `POINT_LIGHT_SCALE`, `SUN_LIGHT_SCALE`, `MAX_LIGHT_ENERGY`, `LIGHT_RANGE`) y un multiplicador por nivel (`light_energy_scale`).
- Intervención humana: el equipo detectó el problema con una captura de pantalla y, después del arreglo, ajustó los colores y confirmó que se ven bien.
- Limitaciones: valores estimados; puede requerir ajuste fino por nivel.

## Entrada 013 — Avance y salto de diálogos
- Herramienta de IA: Claude
- ACTION_TYPE: DEBUGGING
- Archivos: `scripts/ui/hud.gd`, `scenes/ui/hud.tscn`
- Resumen: el equipo no podía avanzar porque no había indicación de cómo pasar el diálogo. Ahora avanza con E, Enter, Espacio o clic; Tab salta el diálogo completo; se agregó una pista en pantalla. También se evitó que la misma pulsación de E que cierra un diálogo reactivara la interacción del jugador.
- Intervención humana: el equipo probó el juego, reportó el bloqueo y confirmó que quedó bien.
- Limitaciones: ninguna conocida.

## Entrada 014 — Cámara trasera dentro del cuarto y modo de movimiento
- Herramienta de IA: Claude
- ACTION_TYPE: DEBUGGING
- Archivos: `scripts/camera/camera_rig.gd`, `scripts/levels/level_base.gd`
- Resumen: en la sala de las catacumbas la cámara trasera quedaba fuera del cuarto (5 m detrás del jugador, con la pared a 2,6 m). Ahora un rayo desde el jugador acerca la cámara si hay una pared o muro invisible en medio. Además el nivel asigna el modo de cámara directamente al jugador y escribe en consola el modo con el que arrancó, para diagnosticar el reporte de que W/S no movían al personaje.
- Intervención humana: el equipo probó el juego y reportó la cámara fuera de la escena y que solo se movía con A y D.
- Limitaciones: **no se ejecutó en Godot**; no se pudo reproducir el problema de W/S, queda pendiente confirmarlo en el editor.

## Entrada 015 — Monja guía en el escenario 2
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/characters/monja.gd`, `scenes/characters/monja.tscn`, `scripts/levels/level_02_pasillo.gd`, `scenes/levels/02_pasillo.tscn`, `scripts/autoload/event_bus.gd`, `scripts/ui/hud.gd`, `scenes/ui/hud.tscn`, `scripts/minigames/flagellation_minigame.gd`, `data/dialogues/monja_guia.json`, `docs/ESCENARIOS.md`
- Resumen: la monja no aparecía porque no existía en la escena. Ahora sale por la puerta tras la conversación, dice sus diálogos, y al terminar las 5 pulsaciones de E habla de nuevo, aparece el letrero «Sigue a la monja» y ella camina hacia la derecha esperando al jugador; la salida sigue siendo tocar la pared derecha. Se agregó un letrero de objetivo reutilizable en el HUD.
- Intervención humana: el equipo describió el comportamiento deseado de la escena; el texto de los diálogos nuevos (`monja_guia.json`) lo redactó la IA y el equipo puede cambiarlo.
- Limitaciones: **no se ejecutó en Godot**; el modelo de la monja es un placeholder y las posiciones (puerta en x=27, salida en x=36) se tomaron de los datos del nivel.

## Entrada 016 — Primera aparición de la monja desde la derecha
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/levels/level_02_pasillo.gd`, `scripts/characters/monja.gd`
- Resumen: la monja ya no sale de la puerta de las voces; en su primera aparición entra caminando desde el extremo derecho del pasillo hasta quedar junto a Malaes.
- Intervención humana: el equipo pidió el cambio.
- Limitaciones: no se ejecutó en Godot; el punto de entrada (x=36) es una estimación.

## Entrada 017 — Cámara trasera estática en horizontal
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/camera/camera_rig.gd`
- Resumen: en las salas de caminata vertical (cámara trasera) la cámara ya no sigue al jugador de lado: se queda fija en el centro del escenario (`behind_fixed_x`) y solo se mueve con el jugador hacia adelante y atrás, para que no muestre zonas fuera del mapa. Se puede desactivar con `lock_x_in_behind`.
- Intervención humana: el equipo decidió este comportamiento de cámara.
- Limitaciones: no se ejecutó en Godot; asume que cada escenario está centrado en X=0.

## Entrada 018 — Carta del escenario 1: más grande y texto a pantalla completa
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/levels/level_01_cuarto.gd`, `scripts/ui/hud.gd`, `scenes/ui/hud.tscn`, `scripts/dialogue/dialogue_db.gd`, `data/dialogues/carta_papa_llama.json`, `docs/ESCENARIOS.md`
- Resumen: la carta del suelo se agranda 3,5 veces, se desliza desde debajo de la puerta y tiene un brillo pálido para notarse. Su texto se muestra como carta (centrado, grande y sobre pantalla oscurecida) en vez de la caja de diálogo; cualquier línea de diálogo con `"style": "letter"` usa este formato.
- Intervención humana: el equipo pidió ambos cambios.
- Limitaciones: no se ejecutó en Godot; tamaño, brillo y tipografía son estimaciones a ajustar viendo el juego. El texto de la carta sigue siendo el de antes («El papa te llama.»).

## Entrada 019 — Espera de 4 s y charco de sangre en el castigo
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/minigames/flagellation_minigame.gd`, `scripts/effects/blood_pool.gd`, `scripts/levels/level_02_pasillo.gd`, `scenes/levels/02_pasillo.tscn`
- Resumen: entre una pulsación de E y la siguiente ahora hay una espera de 4 s (`seconds_between_presses`) con cuenta regresiva en pantalla; las pulsaciones durante la espera no cuentan. Cada golpe derrama más líquido rojo oscuro: un charco plano que se crea bajo los pies del jugador en el primer golpe, crece con cada uno y se queda fijo en el mundo.
- Intervención humana: el equipo pidió el comportamiento.
- Limitaciones: no se ejecutó en Godot; tamaños y aspecto del charco (disco simple) son estimaciones. Sin imagen explícita: solo el charco y el contador.

## Entrada 020 — Lilith huye al terminar su diálogo (escenario 2)
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/levels/level_02_pasillo.gd`
- Resumen: cuando termina el diálogo con Lilith, ella corre rápido hacia la izquierda (8 m/s) hasta salir de la escena y desaparece.
- Intervención humana: el equipo pidió el comportamiento.
- Limitaciones: no se ejecutó en Godot; Lilith sigue siendo un placeholder (cápsula) sin animación.

## Entrada 021 — Cuarto invertido con luz rojiza y comentario sobre la cruz
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/levels/level_03_cuarto_invertido.gd`, `data/dialogues/cruz_invertida.json`, `docs/ESCENARIOS.md`
- Resumen: al volver al cuarto después de seguir a la monja, las luces del cuarto y la luz ambiente se tiñen de rojo, y Malaes dice «Hmmmm... La cruz.» una sola vez, cuando termina el fundido de entrada.
- Intervención humana: el equipo pidió ambos cambios.
- Limitaciones: no se ejecutó en Godot; la intensidad del rojo es una estimación para ajustar viendo el juego.

## Entrada 022 — Túnel más largo hacia atrás en los niveles de cámara trasera
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/levels/level_base.gd`, `scenes/levels/05_catacumbas.tscn`, `scenes/levels/07_persecucion.tscn`, `scenes/levels/09_camino_final.tscn`, `scenes/player/player.tscn`, `project.godot`, `docs/ESCENARIOS.md`
- Resumen: al avanzar los primeros pasos la cámara trasera mostraba la pared de entrada del túnel (quedaba detrás de ella). Ahora el túnel se alarga 8 m hacia atrás repitiendo las mallas del túnel y del piso, y la pared/puerta del inicio se corre al nuevo extremo. El muro invisible que impide retroceder pasa a una capa física propia que la cámara ignora.
- Intervención humana: el equipo reportó el problema y definió la solución (túnel más largo + muro invisible).
- Limitaciones: no se ejecutó en Godot; el tramo nuevo es una copia del túnel original (queda oscuro, sin antorchas) y las mallas no se editaron en Blender. Si queda raro, la solución definitiva es alargar el túnel en Blender.

## Entrada 023 — Carta en latín del escenario 4 como carta a pantalla completa
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `data/dialogues/carta_latin_hallada.json`, `scripts/ui/hud.gd`, `scripts/dialogue/dialogue_db.gd`, `scripts/levels/level_05_catacumbas.gd`
- Resumen: al recoger la carta en latín se muestra centrada en pantalla, con formato de carta, y luego Malaes dice «Está en latín, no entiendo nada.» y «Mejor la guardo.». El formato de carta ahora acepta `font_size` y `width` opcionales para textos largos.
- Intervención humana: el equipo entregó el texto en latín y los diálogos de Malaes; la IA solo los puso en el juego sin cambiarlos.
- Limitaciones: no se ejecutó en Godot; el tamaño de letra (30) y el ancho (900) son estimaciones a ajustar.

## Entrada 024 — Pruebas del equipo en Godot 4.7.2 y archivos generados por el motor
- Herramienta de IA: Claude
- ACTION_TYPE: HUMAN_VERIFICATION
- Archivos: ninguno modificado por la IA en esta entrada (resume lo observado por el equipo)
- Resumen: el equipo ejecutó el juego en Godot 4.7.2 y reportó la consola. Los niveles 01, 02, 03, 04 y 05 cargaron, y en la sala 05 la consola mostró `camara=behind | jugador.mode=behind` (la línea de diagnóstico de la entrada 014), por lo que el jugador sí estaba en modo de cámara trasera. El contador de errores del editor estaba en 0. Al abrir el editor, Godot avisó que `project.godot` había cambiado fuera del editor (la capa física 5 de la entrada 022) y el equipo debía recargarlo. Godot también generó archivos `.uid` junto a los scripts nuevos; se suben al repositorio junto a ellos.
- Intervención humana: el equipo ejecutó el juego, reportó cámara fuera de la escena, movimiento con W/S, y proporcionó la captura de la consola.
- Limitaciones: la IA no puede ejecutar Godot; el reporte de que W/S no movía al personaje en la sala 05 sigue **sin confirmarse como resuelto**. Los cambios de las entradas 014 a 023 están pendientes de probar uno por uno en el editor.

