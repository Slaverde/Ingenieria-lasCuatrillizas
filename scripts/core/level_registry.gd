class_name LevelRegistry
extends RefCounted
## Tabla ID -> escena de cada nivel. Agregar aqui cada nivel nuevo.

const FIRST := &"01_cuarto"

const LEVELS := {
	&"01_cuarto": "res://scenes/levels/01_cuarto.tscn",
	&"02_pasillo": "res://scenes/levels/02_pasillo.tscn",
	&"03_cuarto_invertido": "res://scenes/levels/03_cuarto_invertido.tscn",
	&"04_pasillo_noche2": "res://scenes/levels/04_pasillo_noche2.tscn",
	&"05_catacumbas": "res://scenes/levels/05_catacumbas.tscn",
	&"06_encuentro_lilith": "res://scenes/levels/06_encuentro_lilith.tscn",
	&"07_persecucion": "res://scenes/levels/07_persecucion.tscn",
	&"08_capilla": "res://scenes/levels/08_capilla.tscn",
	&"09_camino_final": "res://scenes/levels/09_camino_final.tscn",
	&"10_sala_papa": "res://scenes/levels/10_sala_papa.tscn",
}

static func path_of(level_id: StringName) -> String:
	return LEVELS.get(level_id, "")
