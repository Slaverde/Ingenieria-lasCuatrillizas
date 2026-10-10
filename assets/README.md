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
