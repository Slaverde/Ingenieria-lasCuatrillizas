extends CanvasLayer
## HUD global (autoload): prompt de interaccion [E] y caja de dialogos estilo Pokemon.
## Avanzar: [E] / [Enter] / [Espacio] / clic. El primero completa el texto, el siguiente pasa a la linea.
## [Tab] salta todo el dialogo.

const CHARS_PER_SEC := 45.0

@onready var _prompt: Label = %PromptLabel
@onready var _panel: PanelContainer = %DialoguePanel
@onready var _speaker: Label = %SpeakerLabel
@onready var _text: Label = %TextLabel
@onready var _portrait: TextureRect = %PortraitRect

var _prompt_text := ""
var _lines: Array = []
var _index := 0
var _active := false
var _accepting := false
var _tween: Tween


func _ready() -> void:
	EventBus.prompt_changed.connect(_on_prompt_changed)
	EventBus.dialogue_requested.connect(_start_dialogue)


func _on_prompt_changed(text: String) -> void:
	_prompt_text = text
	_refresh_prompt()


func _refresh_prompt() -> void:
	_prompt.text = _prompt_text
	_prompt.visible = _prompt_text != "" and not _active


func _start_dialogue(lines: Array) -> void:
	if _active or lines.is_empty():
		return
	_lines = lines
	_index = 0
	_active = true
	_accepting = false
	GameState.lock_input(&"dialogue")
	_panel.show()
	_refresh_prompt()
	_show_line()
	await get_tree().process_frame   # evita que el mismo [E] avance la primera linea
	_accepting = true


func _show_line() -> void:
	var line: Variant = _lines[_index]
	var speaker := ""
	var text := ""
	var portrait := ""
	if line is Dictionary:
		speaker = line.get("speaker", "")
		text = line.get("text", "")
		portrait = line.get("portrait", "")
	else:
		text = str(line)
	_speaker.text = speaker
	_speaker.visible = speaker != ""
	_text.text = text
	_text.visible_ratio = 0.0
	if portrait != "" and ResourceLoader.exists(portrait):
		_portrait.texture = load(portrait)
		_portrait.show()
	else:
		_portrait.hide()
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_text, "visible_ratio", 1.0, maxf(text.length() / CHARS_PER_SEC, 0.05))


func _input(event: InputEvent) -> void:
	if not _active or not _accepting:
		return
	# [Tab] salta todo el dialogo
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_TAB:
		get_viewport().set_input_as_handled()
		_end_dialogue()
		return
	if _is_advance(event):
		get_viewport().set_input_as_handled()
		_advance()


## Avanzan el dialogo: [E], [Enter], [Espacio] o clic izquierdo.
func _is_advance(event: InputEvent) -> bool:
	if event.is_action_pressed(&"interact") or event.is_action_pressed(&"ui_accept"):
		return true
	return event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT


func _advance() -> void:
	if _text.visible_ratio < 1.0:
		if _tween:
			_tween.kill()
		_text.visible_ratio = 1.0
		return
	_index += 1
	if _index >= _lines.size():
		_end_dialogue()
	else:
		_show_line()


func _end_dialogue() -> void:
	if not _active:
		return
	_accepting = false
	if _tween:
		_tween.kill()
	_panel.hide()
	_portrait.hide()
	# Se espera 2 frames de fisica: asi el mismo [E] que cierra el dialogo no reactiva
	# la interaccion del jugador (el jugador lee el input en _physics_process).
	await get_tree().physics_frame
	await get_tree().physics_frame
	_active = false
	GameState.unlock_input(&"dialogue")
	_refresh_prompt()
	EventBus.dialogue_finished.emit()
