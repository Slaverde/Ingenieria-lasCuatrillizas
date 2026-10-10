class_name FlagellationMinigame
extends Node
## Escenario 2: el jugador pulsa [E] 5 veces, con una espera de 4 s entre pulsaciones.
## Emite `hit` en cada golpe y `completed` al final. Al terminar activa el flag `castigo_completado`.
## Este nodo maneja el texto de ayuda en pantalla (listo / espera con cuenta regresiva).

signal hit(count: int, total: int)
signal completed

@export var presses_required := 5
@export var seconds_between_presses := 4.0   # espera obligatoria antes de poder pulsar otra vez

var _count := 0
var _active := false
var _cooldown := 0.0
var _shown_secs := -1


func start() -> void:
	_count = 0
	_cooldown = 0.0
	_active = true
	GameState.lock_input(&"minigame")
	_show_ready()


func _process(delta: float) -> void:
	if not _active or _cooldown <= 0.0:
		return
	_cooldown = maxf(_cooldown - delta, 0.0)
	if _cooldown <= 0.0:
		_show_ready()
		return
	var secs := ceili(_cooldown)
	if secs != _shown_secs:
		_shown_secs = secs
		EventBus.prompt_changed.emit("Resiste...  %d s   (%d/%d)" % [secs, _count, presses_required])


func _unhandled_input(event: InputEvent) -> void:
	if _active and event.is_action_pressed(&"interact"):
		get_viewport().set_input_as_handled()
		if _cooldown > 0.0:
			return   # todavia en espera: la pulsacion no cuenta
		_count += 1
		hit.emit(_count, presses_required)   # TODO: animacion de la espalda y sonido
		if _count >= presses_required:
			_finish()
		else:
			_cooldown = seconds_between_presses
			_shown_secs = -1


func _show_ready() -> void:
	EventBus.prompt_changed.emit("Presiona E  (%d/%d)" % [_count, presses_required])


func _finish() -> void:
	_active = false
	GameState.unlock_input(&"minigame")
	EventBus.prompt_changed.emit("")
	GameState.set_flag(&"castigo_completado")
	completed.emit()
