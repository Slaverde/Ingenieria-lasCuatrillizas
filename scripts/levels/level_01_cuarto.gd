extends LevelBase
## Escenario 1: Malaes despierta, tras unos segundos pasan la carta bajo la puerta.
## Al leerla, la puerta se abre sola.
## TODO: animacion de levantarse de la cama, sfx de toques, animacion real de la puerta.

@export var seconds_before_letter := 5.0

@onready var _letter: Interactable = $Letter

var _carta: Node3D
var _door: Node3D


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
	if _carta:
		_carta.visible = true
	_letter.enabled = true


func _on_flag(flag: StringName, _value: Variant) -> void:
	if flag == &"carta_papa_leida":
		if _carta:
			_carta.visible = false
		if _door:
			_door.visible = false
