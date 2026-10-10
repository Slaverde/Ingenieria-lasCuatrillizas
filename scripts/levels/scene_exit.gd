class_name SceneExit
extends Area3D
## Zona que cambia de nivel al caminar dentro. Si required_flag no esta activo, no hace nada.

@export var target_level: StringName
@export var target_spawn: StringName = &"Default"
@export var required_flag: StringName = &""


func _ready() -> void:
	collision_layer = 0
	collision_mask = 8   # solo el jugador
	body_entered.connect(_try_exit)
	EventBus.flag_changed.connect(_on_flag_changed)


func _on_flag_changed(_flag: StringName, _value: Variant) -> void:
	for body in get_overlapping_bodies():
		_try_exit(body)


func _try_exit(body: Node3D) -> void:
	if not body is Player:
		return
	if required_flag != &"" and not GameState.get_flag(required_flag):
		return
	SceneManager.change_level(target_level, target_spawn)
