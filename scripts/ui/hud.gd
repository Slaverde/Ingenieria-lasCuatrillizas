extends CanvasLayer
## HUD global (autoload): prompt de interaccion [E] y caja de dialogos estilo Pokemon.
## Avanzar: [E] / [Enter] / [Espacio] / clic. El primero completa el texto, el siguiente pasa a la linea.
## [Tab] salta todo el dialogo. Una linea con "auto": N avanza sola a los N segundos (y no se salta con E).
## Una linea con "style": "letter" (ej. la carta) se muestra a pantalla completa, centrada y en grande.
## Si la PRIMERA linea trae "free_walk": true, el dialogo no bloquea al jugador (habla mientras camina);
## se usa con lineas "auto" y se corta solo si se cambia de nivel.

const CHARS_PER_SEC := 45.0

@onready var _prompt: Label = %PromptLabel
@onready var _objective: Label = %ObjectiveLabel
@onready var _panel: PanelContainer = %DialoguePanel
@onready var _speaker: Label = %SpeakerLabel
@onready var _text: Label = %TextLabel
@onready var _portrait: TextureRect = %PortraitRect
@onready var _letter_layer: Control = %LetterLayer
@onready var _letter_text: Label = %LetterText
@onready var _hint: Label = %HintLabel

var _prompt_text := ""
var _lines: Array = []
var _index := 0
var _active := false
var _accepting := false
var _tween: Tween
var _label: Label   # el texto que se esta escribiendo (dialogo o carta)
var _serial := 0           # cambia con cada linea: cancela avances automaticos viejos
var _line_auto := false    # la linea actual avanza sola ("auto": segundos) y no se salta con E
var _free_walk := false    # dialogo que no bloquea el movimiento del jugador


func _ready() -> void:
	EventBus.prompt_changed.connect(_on_prompt_changed)
	EventBus.dialogue_requested.connect(_start_dialogue)
	EventBus.objective_changed.connect(_on_objective_changed)
	EventBus.level_started.connect(_on_level_started)


func _on_prompt_changed(text: String) -> void:
	_prompt_text = text
	_refresh_prompt()


## Letrero fijo de objetivo (ej. "Sigue a la monja"): no depende de lo que el jugador tenga cerca.
func _on_objective_changed(text: String) -> void:
	_objective.text = text
	_objective.visible = text != ""


## Al cambiar de nivel se limpia el objetivo y se corta un dialogo "free_walk" que siguiera en pantalla.
func _on_level_started(_id: StringName) -> void:
	_on_objective_changed("")
	if _active and _free_walk:
		_end_dialogue()


func _refresh_prompt() -> void:
	_prompt.text = _prompt_text
	_prompt.visible = _prompt_text != "" and (not _active or _free_walk)


func _start_dialogue(lines: Array) -> void:
	if _active or lines.is_empty():
		return
	_lines = lines
	_index = 0
	_active = true
	_accepting = false
	_free_walk = lines[0] is Dictionary and bool(lines[0].get("free_walk", false))
	if not _free_walk:
		GameState.lock_input(&"dialogue")
	_refresh_prompt()
	_show_line()
	await get_tree().process_frame   # evita que el mismo [E] avance la primera linea
	_accepting = true


func _show_line() -> void:
	var line: Variant = _lines[_index]
	var speaker := ""
	var text := ""
	var portrait := ""
	var style := "dialogue"
	var font_size := 52        # solo para cartas: "font_size" y "width" son opcionales en el JSON
	var width := 760.0
	var auto_seconds := 0.0
	if line is Dictionary:
		speaker = line.get("speaker", "")
		text = line.get("text", "")
		portrait = line.get("portrait", "")
		style = line.get("style", "dialogue")
		font_size = int(line.get("font_size", 52))
		width = float(line.get("width", 760.0))
		auto_seconds = float(line.get("auto", 0.0))
	else:
		text = str(line)
	var is_letter := style == "letter"
	_panel.visible = not is_letter
	_letter_layer.visible = is_letter
	_label = _letter_text if is_letter else _text
	if is_letter:
		_letter_text.add_theme_font_size_override("font_size", font_size)
		_letter_text.custom_minimum_size.x = width
	_speaker.text = speaker
	_speaker.visible = speaker != ""
	_label.text = text
	_label.visible_ratio = 0.0
	if not is_letter and portrait != "" and ResourceLoader.exists(portrait):
		_portrait.texture = load(portrait)
		_portrait.show()
	else:
		_portrait.hide()
	if _tween:
		_tween.kill()
	var speed := CHARS_PER_SEC * (0.6 if is_letter else 1.0)   # la carta se "lee" mas despacio
	_tween = create_tween()
	var duration := clampf(text.length() / speed, 0.05, 6.0 if is_letter else 30.0)   # cartas largas no tardan mas de 6 s
	_tween.tween_property(_label, "visible_ratio", 1.0, duration)
	_line_auto = auto_seconds > 0.0
	_hint.visible = not _line_auto
	_serial += 1
	if _line_auto:
		_auto_advance(_serial, auto_seconds)


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
	if _line_auto:
		return false   # las lineas automaticas ("auto") no se avanzan con el teclado
	if event.is_action_pressed(&"interact") or event.is_action_pressed(&"ui_accept"):
		return true
	return event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT


func _advance() -> void:
	if _label.visible_ratio < 1.0:
		if _tween:
			_tween.kill()
		_label.visible_ratio = 1.0
		return
	_next_line()


func _next_line() -> void:
	_index += 1
	if _index >= _lines.size():
		_end_dialogue()
	else:
		_show_line()


## Pasa a la siguiente linea despues de `seconds` (lineas con "auto" en el JSON).
func _auto_advance(serial: int, seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	if _active and _accepting and serial == _serial:
		_next_line()


func _end_dialogue() -> void:
	if not _active:
		return
	_accepting = false
	_serial += 1
	_line_auto = false
	if _tween:
		_tween.kill()
	_panel.hide()
	_letter_layer.hide()
	_portrait.hide()
	# Se espera 2 frames de fisica: asi el mismo [E] que cierra el dialogo no reactiva
	# la interaccion del jugador (el jugador lee el input en _physics_process).
	await get_tree().physics_frame
	await get_tree().physics_frame
	_active = false
	_free_walk = false
	GameState.unlock_input(&"dialogue")
	_refresh_prompt()
	EventBus.dialogue_finished.emit()
