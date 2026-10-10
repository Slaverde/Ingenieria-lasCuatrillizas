extends LevelBase
## Escenario 4: libros (carta en latin), altar para rezar y la puerta de los 3 santos.
## Al recoger la carta se muestra como carta (texto en latin) y Malaes comenta que no la entiende y la guarda.
## La puerta tiene 3 estados: examinar -> sacar la carta (ya legible) -> bajar las escaleras.
## TODO: temblor de pantalla y oscuridad al rezar, animacion de la puerta.

@onready var _libros: Interactable = $Biblioteca
@onready var _puerta: Interactable = $PuertaTresDiablos


func _on_level_ready() -> void:
	var carta := find_env_node("Carta_Latin")
	if carta:
		_libros.global_position = carta.global_position + Vector3(0, 0.5, 0)
	_puerta.interacted.connect(_on_puerta)
	_refresh_prompt()


func _on_puerta(_player: Node3D) -> void:
	if GameState.get_flag(&"carta_descifrada"):
		SceneManager.change_level(&"06_encuentro_lilith")
	elif not GameState.get_flag(&"vio_puerta_3_diablos"):
		GameState.set_flag(&"vio_puerta_3_diablos")
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("puerta_3_diablos"))
		await EventBus.dialogue_finished
		_refresh_prompt()
	elif GameState.get_flag(&"carta_latin_guardada"):
		GameState.set_flag(&"carta_descifrada")
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("carta_latin_legible"))
		await EventBus.dialogue_finished
		_refresh_prompt()
	else:
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("puerta_sin_carta"))


func _refresh_prompt() -> void:
	if GameState.get_flag(&"carta_descifrada"):
		_puerta.prompt_text = "Bajar las escaleras"
	elif GameState.get_flag(&"vio_puerta_3_diablos") and GameState.get_flag(&"carta_latin_guardada"):
		_puerta.prompt_text = "Sacar la carta"
	else:
		_puerta.prompt_text = "Examinar la puerta"
