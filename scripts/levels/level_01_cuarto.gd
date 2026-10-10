extends LevelBase
## Escenario 1: Malaes despierta, tras unos segundos pasan la carta bajo la puerta.
## Al leerla, la puerta se abre sola.
## TODO: animacion de levantarse de la cama, sfx de toques, animacion real de la puerta.

@export var seconds_before_letter := 5.0
## La carta del glb es diminuta (~24 cm): se agranda para que se note desde la camara.
@export var letter_scale := 3.5
const LETTER_START_X := 3.0       # bajo la puerta (la puerta esta en x ~ 3.1)
const LETTER_SLIDE_TIME := 1.2

@onready var _letter: Interactable = $Letter

var _carta: Node3D
var _door: Node3D
var _glow: OmniLight3D


func _on_level_ready() -> void:
	_carta = find_env_node("Carta")
	_door = find_env_node("Puerta")
	if _carta:
		_letter.global_position = _carta.global_position + Vector3(0, 0.4, 0)
	if GameState.get_flag(&"carta_papa_leida"):
		if _carta:
			_carta.visible = false
		if _door:
			_door.visible = false
		return
	if _carta:
		_carta.visible = false
	EventBus.flag_changed.connect(_on_flag)
	await get_tree().create_timer(seconds_before_letter).timeout
	await _show_letter()
	_letter.enabled = true


## La carta se desliza desde debajo de la puerta hasta su lugar, agrandada y con un brillo palido.
func _show_letter() -> void:
	if _carta == null:
		return
	var final_pos := _carta.global_position
	_carta.scale *= letter_scale
	_carta.global_position.x = LETTER_START_X
	_carta.visible = true
	_glow = OmniLight3D.new()
	_glow.light_color = Color(1.0, 0.92, 0.7)
	_glow.light_energy = 0.0
	_glow.omni_range = 2.5
	add_child(_glow)
	_glow.global_position = final_pos + Vector3(0, 0.6, 0.4)
	var tween := create_tween().set_parallel(true)
	tween.tween_property(_carta, "global_position:x", final_pos.x, LETTER_SLIDE_TIME).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(_glow, "light_energy", 1.2, LETTER_SLIDE_TIME)
	await tween.finished


func _on_flag(flag: StringName, _value: Variant) -> void:
	if flag == &"carta_papa_leida":
		if _glow:
			_glow.queue_free()
		if _carta:
			_carta.visible = false
		if _door:
			_door.visible = false
