# Assets (Blender -> Godot)

Todo lo visual se modela en Blender y se exporta a **glTF 2.0 binario (`.glb`)**. Godot los importa solo.

## Carpetas
| Carpeta | Contenido |
|---|---|
| `characters/malaes` | Malaes (protagonista) + animaciones: despertar, caminar, correr, saltar, rezar, autoflagelarse, llorar |
| `characters/lilith` | Lilith en sus dos formas: niña (llorando, acostada) y monstruo. Animaciones: llorar, levantarse, correr, despedazar |
| `characters/monja` | La monja (cara/cuerpo que se retuerce) |
| `characters/papa` | El Papa + corona + animacion de prenderse en fuego |
| `environments/*` | Un subdirectorio por locacion: `cuarto`, `pasillo`, `catacumbas`, `capilla`, `sala_papa` |
| `props/` | Cama, cruz (normal e invertida), latigo, carta, velas, altar, libros, estanterias, estatuas, cuadros |
| `ui/portraits` | Retratos para dialogos estilo Pokemon (`lilith.png`, `monja.png`, `papa.png`, `malaes.png`) |
| `ui/fonts`, `ui/icons` | Fuentes e iconos |
| `audio/music`, `audio/sfx`, `audio/voice` | Audio (`.ogg` preferido) |
| `vfx/` | Sangre, fuego, particulas |
| `blender_sources/` | Los `.blend` originales (no los lee Godot) |

## Convenciones de exportacion (para quien modela)
- Formato: `.glb`, **Y-up** (opcion por defecto del exportador glTF), escala **1 unidad = 1 metro**.
- El personaje **mira hacia -Z** en reposo (asi lo espera `player.gd`). Origen en los **pies**.
- Altura de Malaes: ~**1.0 m** (es un niño). La capsula de colision mide 1.0 x 0.6.
- Animaciones en el mismo `.glb`, con nombres en minuscula: `idle`, `walk`, `run`, `jump`, `pray`, `whip`, `cry`, `wake`, `die`...
- Nombres de archivo: `snake_case`, sin espacios ni tildes (`monja_idle.glb`, `cruz_invertida.glb`).
- Los modelos de escenarios se modelan por **modulo** (tramo de pasillo, etc.) para reutilizar el fondo, como pide el guion.
- Colision: se puede agregar sufijo `-col` a una malla en Blender para que Godot genere la colision.

## Como reemplazar el placeholder
`scenes/player/player.tscn` -> nodo `ModelPivot/PlaceholderMesh`: borrarlo e instanciar el `.glb` de Malaes dentro de `ModelPivot`.

## Estado de los personajes (modelos del compañero de Blender)
Los modelos llegan como `.glb` con esqueleto, colores simples (sin texturas) y **sin animaciones** (T-pose). Miden ~1,7 m y **miran hacia +Z**.
| Personaje | Archivo | En el juego |
|---|---|---|
| Malaes | `characters/malaes/malaes.glb` | Integrado: `scenes/characters/malaes_model.tscn` (escala 0,6 → ~1,04 m porque es un niño; girado 180° para mirar a -Z) |
| Lilith humana | `characters/lilith/lilith_humana.glb` | Integrada (`lilith_humana_model.tscn`, escala 0,6 → niña pequeña como Malaes): pasillo (02) y galería (06) |
| Monja | `characters/monja/monja.glb` | Integrada (`monja_model.tscn`, escala 1,0 ≈ 1,65 m): pasillo (02) |
| Lilith monstruo (entidad catacumbas) | `characters/lilith/entidad_catacumbas.glb` | Integrada (`entidad_model.tscn`, escala 1,5 ≈ 2,6 m, «demasiado grande» según el guion): transformación (06), persecución (07), camino final (09) y sala del Papa (10) |
| Papa | `characters/papa/papa.glb` | Integrado (`papa_model.tscn`, escala 1,0 ≈ 2,1 m con tiara): sala del Papa (10), sobre el estrado y mirando hacia +Z |

`scripts/characters/character_model.gd` baja los brazos y los balancea al caminar por código, mientras no haya animaciones reales en los `.glb`.

