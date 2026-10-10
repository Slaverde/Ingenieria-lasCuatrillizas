class_name LilithCompanion
extends Node3D
## Lilith monstruo caminando junto a Malaes en el camino final (no puede alejarse).

@export var side_offset := 1.3

var _target: Node3D


func _ready() -> void:
	_target = get_tree().get_first_node_in_group(&"player")


func _process(_delta: float) -> void:
	if _target:
		global_position = Vector3(side_offset, 0.0, _target.global_position.z)
