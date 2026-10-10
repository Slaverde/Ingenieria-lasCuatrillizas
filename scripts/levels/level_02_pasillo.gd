extends LevelBase
## Escenario 2: Lilith llorando, conversacion tras la puerta, la monja descubre a Malaes
## y lo castiga (5 pulsaciones de E). Despues se abre la salida.
## El castigo NO se muestra de forma explicita: solo el contador en pantalla.
## TODO: la monja en escena, efectos de camara/sonido, pasillos repetidos.

@onready var _castigo: FlagellationMinigame = $Castigo


func _on_level_ready() -> void:
	_castigo.hit.connect(func(count: int, total: int) -> void:
		EventBus.prompt_changed.emit("Presiona E  (%d/%d)" % [count, total]))
	_castigo.completed.connect(func() -> void: EventBus.prompt_changed.emit(""))
	EventBus.flag_changed.connect(_on_flag)


func _on_flag(flag: StringName, _value: Variant) -> void:
	if flag == &"escucho_conversacion":
		_escena_monja()


func _escena_monja() -> void:
	await EventBus.dialogue_finished          # termina la conversacion tras la puerta
	await get_tree().create_timer(0.6).timeout
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("monja_descubre"))
	await EventBus.dialogue_finished
	_castigo.start()
