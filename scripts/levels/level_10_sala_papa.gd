extends LevelBase
## Escenario 7: el Papa. Dialogos finales y "AHORA ERES EL PAPA".
## TODO: el Papa se prende en fuego, primer plano de Malaes con la corona, creditos.

func _on_level_ready() -> void:
	GameState.lock_input(&"final")
	await get_tree().create_timer(1.5).timeout
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("papa_final"))
	await EventBus.dialogue_finished
	GameState.set_flag(&"fin_del_juego")
