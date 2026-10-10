class_name FlagellationMinigame
extends Node
## Escenario 2: el jugador pulsa [E] 5 veces. Emite `hit` en cada golpe y `completed` al final.
## Al terminar activa el flag `castigo_completado`.

signal hit(count: int, total: int)
signal completed

@export var presses_required := 5

var _count := 0
var _active := false


func start() -> void:
	_count = 0
	_active = true
	GameState.lock_input(&"minigame")
	EventBus.prompt_changed.emit("Presiona E para empezar")


func _unhandled_input(event: InputEvent) -> void:
	if _active and event.is_action_pressed(&"interact"):
		get_viewport().set_input_as_handled()
		_count += 1
		hit.emit(_count, presses_required)   # TODO: animacion + sangre en la espalda
		if _count >= presses_required:
			_finish()


func _finish() -> void:
	_active = false
	GameState.unlock_input(&"minigame")
	EventBus.prompt_changed.emit("")
	GameState.set_flag(&"castigo_completado")
	completed.emit()
