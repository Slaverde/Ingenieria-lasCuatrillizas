class_name InvisibleWall
extends StaticBody3D
## Bloqueo "no visual" de salidas de escena (guion). Se abre al activarse unlock_flag.

@export var unlock_flag: StringName = &""


func _ready() -> void:
	EventBus.flag_changed.connect(func(_f: StringName, _v: Variant) -> void: _apply())
	_apply()


func _apply() -> void:
	var open: bool = unlock_flag != &"" and GameState.get_flag(unlock_flag)
	set_deferred("collision_layer", 0 if open else 1)
