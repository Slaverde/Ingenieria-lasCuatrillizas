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

## Entrada 025 — Ritual del altar y secuencia de la puerta en las catacumbas
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `scripts/levels/level_05_catacumbas.gd`, `scenes/levels/05_catacumbas.tscn`, `scripts/ui/hud.gd`, `scenes/ui/hud.tscn`, `data/dialogues/rezar_altar.json`, `data/dialogues/rezar_protagonista.json`, `data/dialogues/puerta_espera.json`, `data/dialogues/carta_latin_legible.json`, `docs/ESCENARIOS.md`
- Resumen: al rezar en el altar hay 5 s de luces rojas intermitentes mientras aparece la frase en latín (línea automática, sin saltar con E); al terminar, Malaes dice que eran demonios y que entendió todo. Al llegar a la puerta salta «¡ESPERA!…», aparece «Sacar la carta» y con E se muestra la carta traducida en formato de carta; solo entonces la puerta se abre con E. El HUD ahora admite líneas con `"auto": segundos`.
- Intervención humana: el equipo escribió los textos de los diálogos y de la carta traducida, y definió el orden de los eventos; la IA los puso en el juego. Se agregaron tildes y signos (¡ ?) a los textos del equipo.
- Limitaciones: no se ejecutó en Godot; intensidad, rango y ritmo de las luces rojas son estimaciones. La zona que activa «ESPERA!» es una caja de 3 m frente a la puerta.

## Entrada 026 — Personaje 1/5: Malaes (modelo de Blender integrado al juego)
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `assets/characters/malaes/malaes.glb`, `assets/blender_sources/malaes.blend`, `scenes/characters/malaes_model.tscn`, `scripts/characters/character_model.gd`, `scenes/player/player.tscn`, `scripts/player/player.gd`, `assets/README.md`
- Resumen: el compañero entregó los modelos de los 5 personajes (Malaes, Lilith humana, monja, Lilith monstruo y Papa). Se analizaron los `.glb` (esqueleto sin animaciones, colores simples sin texturas, ~1,7 m, miran hacia +Z) y se integró primero Malaes: reemplaza la cápsula del jugador, escalado a ~1,04 m (es un niño según el guion), girado para mirar hacia -Z, con los brazos bajados y balanceo al caminar hecho por código.
- Intervención humana: el compañero modeló los personajes en Blender; el equipo revisará en Godot cada personaje antes de pasar al siguiente.
- Limitaciones: no se ejecutó en Godot; la escala (0,6) y el ángulo de los brazos (72°) son estimaciones. Los modelos no traen animaciones reales ni texturas. Los otros cuatro personajes siguen pendientes.

## Entrada 027 — Personaje 2/5: Lilith humana
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `assets/characters/lilith/lilith_humana.glb`, `assets/blender_sources/lilith_humana.blend`, `scenes/characters/lilith_humana_model.tscn`, `scenes/levels/02_pasillo.tscn`, `scenes/levels/06_encuentro_lilith.tscn`, `scripts/levels/level_02_pasillo.gd`
- Resumen: el modelo reemplaza a la cápsula de Lilith en el pasillo (escenario 2), donde corre al irse, y en la galería (escenario 6) hasta que se transforma. Escala 0,6 (niña pequeña como Malaes), mirando hacia el jugador.
- Intervención humana: el compañero modeló el personaje; el equipo pidió integrarlos todos y revisará en Godot.
- Limitaciones: no se ejecutó en Godot; sin animaciones (está de pie en lugar de arrodillada/llorando); escala estimada.

## Entrada 028 — Personaje 3/5: Monja
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `assets/characters/monja/monja.glb`, `assets/blender_sources/monja.blend`, `scenes/characters/monja_model.tscn`, `scenes/characters/monja.tscn`, `scripts/characters/monja.gd`
- Resumen: el modelo reemplaza a la monja placeholder del escenario 2; camina con el balanceo de brazos por código al entrar y al guiar a Malaes.
- Intervención humana: el compañero modeló el personaje; el equipo revisará en Godot.
- Limitaciones: no se ejecutó en Godot; sin animaciones reales (ni de azotar con el látigo).

## Entrada 029 — Personaje 4/5: Lilith monstruo (entidad de las catacumbas)
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `assets/characters/lilith/entidad_catacumbas.glb`, `assets/blender_sources/entidad_catacumbas.blend`, `scenes/characters/entidad_model.tscn`, `scenes/levels/06_encuentro_lilith.tscn`, `scenes/levels/07_persecucion.tscn`, `scenes/levels/09_camino_final.tscn`, `scenes/levels/10_sala_papa.tscn`, `scripts/levels/level_06_encuentro_lilith.gd`, `scripts/enemies/lilith_chaser.gd`, `scripts/enemies/lilith_companion.gd`
- Resumen: el modelo es la forma monstruo de Lilith: aparece cuando se transforma (escenario 6), la persigue (7), la acompaña (9) y está junto a Malaes en la sala del Papa (10). Escala 1,5 (~2,6 m) para que se vea enorme frente a Malaes, como pide el guion.
- Intervención humana: el compañero modeló el personaje; el equipo revisará en Godot.
- Limitaciones: no se ejecutó en Godot; la escala es una estimación; sin animaciones reales ni la ropa de monja desgarrada del guion.

## Entrada 030 — Personaje 5/5: Papa
- Herramienta de IA: Claude
- ACTION_TYPE: AI_ASSISTED
- Archivos: `assets/characters/papa/papa.glb`, `assets/blender_sources/papa.blend`, `scenes/characters/papa_model.tscn`, `scenes/levels/10_sala_papa.tscn`, `scripts/characters/character_model.gd`
- Resumen: el modelo reemplaza al Papa placeholder en el estrado de la sala final, mirando hacia el jugador. El baculo está pegado a la mano derecha, así que esa mano se mantiene vertical y el brazo baja solo 20° para que el báculo no atraviese el piso.
- Intervención humana: el compañero modeló el personaje; el equipo revisará en Godot.
- Limitaciones: no se ejecutó en Godot; sin animaciones (falta la de prenderse en fuego) y el ajuste del báculo es una estimación.

## Entrada 031 — Orientación de los personajes en los niveles de movimiento vertical
- Herramienta de IA: Claude
- ACTION_TYPE: DEBUGGING
- Archivos: `scripts/characters/character_model.gd`
- Resumen: en los niveles de cámara trasera Malaes se veía de frente al avanzar y de espaldas al retroceder (al revés). Se comprobó que en los `.glb` la punta del pie está hacia +Z y se había girado el modelo 180° suponiendo que Godot lo dejaba así; como el resultado en pantalla era el contrario, ahora el modelo mide hacia dónde mira realmente (hueso del pie vs. hueso del tobillo) y se gira solo si hace falta para mirar hacia -Z. Escribe en consola si tuvo que girar.
- Intervención humana: el equipo detectó y reportó el problema al probar el juego.
- Limitaciones: no se ejecutó en Godot; la causa exacta (cómo orienta Godot el modelo importado) no pudo confirmarse sin el editor, por eso se midió en tiempo de ejecución. Afecta a los 5 personajes.

## Entrada 032 — Mirada de Malaes invertida solo en los niveles de movimiento vertical
- Herramienta de IA: Claude
- ACTION_TYPE: DEBUGGING
- Archivos: `scripts/player/player.gd`
- Resumen: el equipo pidió invertir la orientación de la mirada de Malaes únicamente en las escenas de movimiento vertical (cámara trasera), dejando las laterales como estaban. Se agregó un giro de 180° del modelo solo en ese modo (`flip_in_behind_mode`), tanto en la postura inicial como al moverse.
- Intervención humana: el equipo probó el juego, indicó qué escenas estaban bien y cuáles había que invertir.
- Limitaciones: no se ejecutó en Godot. Es la segunda vez que se ajusta esta orientación (ver entrada 031), así que la causa de fondo no está confirmada; si queda al revés basta poner `flip_in_behind_mode` en false.

## Entrada 033 — Hitboxes, estatuas de la galería, puerta de la persecución, carta de la capilla y camino hacia el Papa
- Herramienta de IA: Claude
- ACTION_TYPE: CODE_GENERATION
- Archivos: `scripts/levels/level_base.gd`, `scripts/levels/level_10_sala_papa.gd`, `scripts/enemies/lilith_companion.gd`, `scenes/levels/05_catacumbas.tscn`, `06_encuentro_lilith.tscn`, `07_persecucion.tscn`, `08_capilla.tscn`, `10_sala_papa.tscn`, `data/dialogues/nota_samael.json`
- Resumen: (1) Hitboxes: la estantería de las catacumbas (`Estante_*`) no tenía colisión; se agregó `solid_box_prefixes` en `LevelBase`, que agrupa las mallas de un mueble en una sola caja sólida (así no se puede entrar entre sus tablas). Las 6 estanterías de la persecución pasaron de colisión convexa por pieza a caja sólida por mueble. (2) Las estatuas de la galería (nivel 06) estaban sobre la línea por la que camina Malaes; se corren 1.3 m hacia la cámara con `shift_prefixes`/`shift_offset` (nuevos en `LevelBase`). (3) Persecución: la zona de la tecla E pasó de 1 m a 10 m de largo y de ancho completo, el tiempo para pulsarla de 1.5 s a 4 s, y la zona de salida por la puerta se hizo más profunda y de ancho completo (antes el jugador la podía pasar corriendo antes de pulsar E). (4) La nota de la capilla (`nota_samael`) ahora usa `"style": "letter"` y el aviso dice "Leer la carta". (5) Sala del Papa: Lilith camina junto a Malaes (se reutilizó `lilith_companion.gd`, ahora también sigue la altura); los muros invisibles se alargaron hasta el fondo de la sala; se agregó la colisión de la escalinata (`add_ramp_z`, nueva en `LevelBase`) y de la plataforma; los diálogos empiezan solo cuando Malaes cruza `z = -47` ya arriba de la escalinata, con el letrero "Avanza hacia el Papa".
- Intervención humana: el equipo pidió los cinco ajustes y los revisará jugando.
- Limitaciones: no se ejecutó en Godot. Los valores (1.3 m de corrimiento, zonas de la persecución, pendiente de la escalinata a partir de las medidas del .glb) se calcularon leyendo las medidas del modelo, no viéndolo en pantalla; pueden necesitar ajuste fino. Las cajas sólidas de estanterías inclinadas cubren su caja envolvente, que es algo más grande que la forma real.

## Entrada 034 — Diálogos al llegar a la puerta de los tres santos
- Herramienta de IA: Claude
- ACTION_TYPE: CODE_GENERATION
- Archivos: `data/dialogues/puerta_espera.json`, `scripts/levels/level_05_catacumbas.gd`
- Resumen: después de rezar, al llegar a la puerta final Malaes dice primero "¿Será esta la puerta que mencionó Lilith?", "Pero ella dijo que eran tres demonios, y estos son... tres santos..." y "A menos que…", y a continuación siguen los diálogos de la carta en latín ("¡ESPERA!", "LA CARTA... ESTABA EN LATÍN.", "Veámosla."), la opción de sacar la carta y la apertura de la puerta. Todo va en el mismo diálogo; además se marca `vio_puerta_3_diablos` para que no se repita el diálogo viejo de "Examinar la puerta".
- Intervención humana: el equipo dictó el texto y el orden de los diálogos.
- Limitaciones: no se ejecutó en Godot.

## Entrada 035 — Diálogos automáticos de Lilith durante la caminata final
- Herramienta de IA: Claude
- ACTION_TYPE: CODE_GENERATION
- Archivos: `data/dialogues/lilith_camino.json`, `scripts/levels/level_09_camino_final.gd`, `scripts/ui/hud.gd`, `scripts/dialogue/dialogue_db.gd`
- Resumen: mientras Malaes camina junto a Lilith hacia la puerta del Papa (nivel 09), Lilith dice cuatro líneas que avanzan solas, 4.5 s cada una y sin que el jugador las pase, empezando 2 s después de entrar al nivel. Para que el jugador pueda seguir caminando mientras ella habla, el HUD acepta una opción nueva, `"free_walk": true` en la primera línea del diálogo, que no bloquea el movimiento; si se cambia de nivel mientras habla, el diálogo se corta. Se corrigieron dos erratas del texto dictado: "Maleas" por "Malaes" y "el el heredero" por "el heredero".
- Intervención humana: el equipo dictó los textos y pidió que corrieran solos, con un tiempo prudente.
- Limitaciones: no se ejecutó en Godot. Los 4.5 s por línea y los 2 s de espera son estimaciones; con la velocidad de caminata (2.5 m/s) los cuatro diálogos terminan hacia los 20 s, antes de llegar a la puerta (a unos 25 s).
