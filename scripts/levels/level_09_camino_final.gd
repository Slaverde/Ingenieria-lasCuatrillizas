extends LevelBase
## Escenario 5 (bis): Malaes camina hacia la puerta del Papa junto a Lilith monstruo.
## Solo se puede avanzar. Reutiliza el modelo de la persecucion sin los obstaculos.
## Mientras caminan, Lilith habla sola (lineas automaticas que no bloquean el movimiento).

const DIALOGUE_DELAY := 2.0   # segundos antes de que Lilith empiece a hablar

func _on_level_ready() -> void:
	var player := get_tree().get_first_node_in_group(&"player") as Player
	player.allow_backwards = false
	await get_tree().create_timer(DIALOGUE_DELAY).timeout
	if is_inside_tree():
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("lilith_camino"))
