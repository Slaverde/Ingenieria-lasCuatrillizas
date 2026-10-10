# Escenarios del juego -> niveles del proyecto

Los escenarios 3D se modelan en Blender (`assets/blender_sources/*.blend`) y se exportan a `.glb` en `assets/environments/<lugar>/`.
Cada nivel (`scenes/levels/NN_*.tscn`) instancia su `.glb` como nodo `Environment`.
El guion original tiene dos "Escenario 5"; aquí están renumerados en 10 niveles (IDs en `scripts/core/level_registry.gd`).

| Nivel | Guion | Modelo (.glb) | Cámara | Qué hace hoy | Pendiente |
|---|---|---|---|---|---|
| `01_cuarto` | Esc. 1 | `cuarto` | lateral (fija) | Carta aparece a los 5 s, se lee con E, la puerta desaparece y se puede salir | Animación de despertar y de la puerta, toques en la puerta |
| `02_pasillo` | Esc. 2 | `pasillo` | lateral | Lilith (diálogo), conversación tras la puerta, la monja descubre a Malaes y el castigo (5 × E, sin imagen explícita) abre la salida | Monja en escena, efectos, pasillos repetidos |
| `03_cuarto_invertido` | Esc. 3 | `cuarto` | lateral | Mismo cuarto con la **cruz invertida** y la puerta abierta | Animación de despertar |
| `04_pasillo_noche2` | Esc. 3 (pasillo) | `pasillo` | lateral | Puertas abiertas; la del fondo lleva a las catacumbas | — |
| `05_catacumbas` | Esc. 4 | `catacumbas` | **a la espalda** | Libros (guardar la carta), altar (rezar) y puerta de los 3 santos con 3 estados: examinar → sacar la carta → bajar | Temblor/oscuridad al rezar |
| `06_encuentro_lilith` | Esc. 5 (1) | `galeria` | lateral | Escalera con rampas de colisión, diálogo con Lilith; al terminar pasa a la persecución | Transformación de Lilith, letrero rojo, "Lilith?!" |
| `07_persecucion` | Esc. 5 (2) | `persecucion` | **a la espalda** | Shift corre, Espacio salta, obstáculos con colisión, Lilith persigue, QTE "E para esconderte" | Animación de muerte, reinicio desde la transformación, ajustar velocidades |
| `08_capilla` | Esc. 6 | `capilla` | **a la espalda** | Recoger la nota y pasar al siguiente nivel | Primer plano de Malaes llorando; ensanchar la zona caminable |
| `09_camino_final` | Esc. 5 (bis) | `persecucion` (sin obstáculos) | **a la espalda** | Camina hacia la puerta del Papa con Lilith al lado; sin retroceder | Modelo/animación de Lilith |
| `10_sala_papa` | Esc. 7 | `sala_papa` | **a la espalda** | Diálogos finales y "AHORA ERES EL PAPA" | Papa en fuego, corona, créditos |

## Flags de historia
`carta_papa_leida`, `vio_a_lilith`, `escucho_conversacion`, `castigo_completado`, `carta_latin_guardada`, `rezo_en_altar`,
`vio_puerta_3_diablos`, `carta_descifrada`, `encuentro_lilith_terminado`, `persecucion_superada`, `nota_leida`, `fin_del_juego`.

## Convenciones del código para los escenarios
- **Orientación:** Blender (Z arriba, +Y al fondo) se exporta a Godot (Y arriba, -Z al fondo). La cámara lateral queda en +Z mirando a -Z.
- **Suelo:** la cara superior del piso está en `y = 0`.
- **Colisiones:** el jugador camina sobre un suelo invisible (`SafetyFloor`) y entre paredes invisibles (`Walls`). Los obstáculos y el mobiliario reciben colisión por **prefijo de nombre** (`collision_prefixes` en la raíz del nivel). Las escaleras usan rampas (`add_ramp` en `level_base.gd`) porque Godot no sube peldaños.
- **Ocultar partes del modelo:** `hide_prefixes` (puertas abiertas, obstáculos, carta...).
- **Luces:** se importan las luces de Blender (vienen en candelas/lux, por eso `level_base.gd` las convierte con `POINT_LIGHT_SCALE`, `SUN_LIGHT_SCALE`, `MAX_LIGHT_ENERGY` y `LIGHT_RANGE`). Para aclarar u oscurecer UN nivel: `light_energy_scale` en su raíz. Las sombras están apagadas por rendimiento (`lights_cast_shadows`).
- **Cámaras de Blender:** se descartan; el juego usa `CameraRig`. Cada nivel puede ajustarla con `offset_bias`, `look_bias`, `min_x`, `max_x`.
- **Marcadores de Blender** (`Marcador_*`): sirven de referencia; en los niveles ya están usados sus puntos como spawns e interactuables.

## Cómo agregar un nivel
1. Exportar la escena de Blender a `.glb` en `assets/environments/<lugar>/`.
2. Copiar un nivel parecido de `scenes/levels/` y cambiar el `.glb` del nodo `Environment`.
3. Registrarlo en `scripts/core/level_registry.gd`.
4. Lógica propia: un script que extienda `LevelBase` y sobrescriba `_on_level_ready()`.

## Cómo agregar un diálogo
Crear `data/dialogues/<id>.json` y ponerle `dialogue_id = "<id>"` a un `Interactable`, o llamar
`EventBus.dialogue_requested.emit(DialogueDB.load_lines("<id>"))`.
