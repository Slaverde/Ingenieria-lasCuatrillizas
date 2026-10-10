# Escenarios del juego -> niveles del proyecto

El guion original tiene dos "Escenario 5". Aqui estan renumerados en 10 niveles (IDs en `scripts/core/level_registry.gd`).

| Nivel | Guion | Camara | Salida | Estado |
|---|---|---|---|---|
| `01_cuarto` | Esc. 1 | side | camina a la derecha, requiere `carta_papa_leida` | Carta con timer + dialogo ✅ · TODO: animacion de despertar, toques de puerta |
| `02_pasillo` | Esc. 2 | side | derecha, requiere `castigo_completado`; vuelve al cuarto a la izquierda | Lilith con dialogo ✅ · TODO: pasillos repetidos, puerta de conversacion, monja, `FlagellationMinigame` (ya existe el script, falta conectarlo) |
| `03_cuarto_invertido` | Esc. 3 | side | derecha | Solo esqueleto · TODO: cruz invertida |
| `04_pasillo_noche2` | Esc. 3 (pasillo) | side | puerta (interactuar) | Solo esqueleto · TODO: puerta abierta |
| `05_catacumbas` | Esc. 4 | **behind** | puerta (requiere `carta_descifrada`) | Solo esqueleto · TODO: biblioteca (guardar carta, sin inventario), altar "rezar", puerta de los 3 diablos |
| `06_encuentro_lilith` | Esc. 5 (parte 1) | side | derecha, requiere `encuentro_lilith_terminado` | Solo esqueleto · TODO: dialogos + transformacion de Lilith |
| `07_persecucion` | Esc. 5 (parte 2) | **behind** | final, requiere `persecucion_superada` | Scripts base ✅ (`LilithChaser`, `HideQTE`) · TODO: obstaculos, esquivar, correr con Shift, dialogos mientras corre, respawn al inicio de la transformacion |
| `08_capilla` | Esc. 6 | side | requiere `nota_leida` | Solo esqueleto · TODO: altar, cuadro, nota, primer plano llorando |
| `09_camino_final` | Esc. 5 (bis) | **behind** | puerta | Solo esqueleto · TODO: avanzar junto a Lilith |
| `10_sala_papa` | Esc. 7 | side | (final) | Solo esqueleto · TODO: dialogos del Papa, fuego, cartel "AHORA ERES EL PAPA" |

## Flags de historia usados
`carta_papa_leida`, `vio_a_lilith`, `castigo_completado`, `carta_latin_guardada`, `carta_descifrada`, `encuentro_lilith_terminado`, `persecucion_superada`, `nota_leida`.

## Como agregar un nivel
1. Crear `scenes/levels/NN_nombre.tscn` (copiar uno existente; la raiz usa `level_base.gd`).
2. Registrarlo en `scripts/core/level_registry.gd`.
3. Poner `Spawns/Default` y, si se vuelve desde la derecha, `Spawns/FromRight`.
4. Logica especifica: hacer un script que extienda `LevelBase` y sobrescribir `_on_level_ready()` (ver `level_01_cuarto.gd`).

## Como agregar un dialogo
Crear `data/dialogues/<id>.json` y ponerle `dialogue_id = "<id>"` a un `Interactable`, o llamar
`EventBus.dialogue_requested.emit(DialogueDB.load_lines("<id>"))`.
