extends LevelBase
## Escenario 3: el mismo cuarto, pero con la cruz invertida y la puerta abierta desde el inicio.
## TODO: animacion de levantarse de la cama.

func _on_level_ready() -> void:
	var cruz := find_env_node("Cruz")
	if cruz:
		cruz.rotate_z(PI)   # el pivote de la cruz esta en su centro
