class_name LilithCompanion
extends Node3D
## Lilith monstruo caminando junto a Malaes en el camino final (no puede alejarse).

@export var side_offset := 1.3

var _target: Node3D
var _last_z := 0.0

@onready var _model: CharacterModel = get_node_or_null("LilithModel") as CharacterModel


func _ready() -> void:
	_target = get_tree().get_first_node_in_group(&"player")


func _process(delta: float) -> void:
	if _target:
		global_position = Vector3(side_offset, _target.global_position.y, _target.global_position.z)   # sube escaleras con Malaes
		if _model and delta > 0.0:
			_model.set_move_speed(absf(global_position.z - _last_z) / delta)   # camina al ritmo de Malaes
		_last_z = global_position.z
