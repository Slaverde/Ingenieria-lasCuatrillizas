extends LevelBase
## Escenario 5 (bis): Malaes camina hacia la puerta del Papa junto a Lilith monstruo.
## Solo se puede avanzar. Reutiliza el modelo de la persecucion sin los obstaculos.

func _on_level_ready() -> void:
	var player := get_tree().get_first_node_in_group(&"player") as Player
	player.allow_backwards = false
