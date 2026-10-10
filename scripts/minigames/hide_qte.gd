class_name HideQTE
extends Node
## Quick time event de la persecucion: "Presiona E para esconderte".
## Si no se pulsa a tiempo emite `failed` (y muere el jugador).

signal succeeded
signal failed

@export var time_limit := 1.5

var _active := false


func start() -> void:
	_active = true
	EventBus.prompt_changed.emit("Presiona E para esconderte")
	await get_tree().create_timer(time_limit).timeout
	if _active:
		_resolve(false)


func _unhandled_input(event: InputEvent) -> void:
	if _active and event.is_action_pressed(&"interact"):
		get_viewport().set_input_as_handled()
		_resolve(true)


func _resolve(ok: bool) -> void:
	_active = false
	EventBus.prompt_changed.emit("")
	if ok:
		GameState.set_flag(&"persecucion_superada")
		succeeded.emit()
	else:
		failed.emit()
		EventBus.player_died.emit()
