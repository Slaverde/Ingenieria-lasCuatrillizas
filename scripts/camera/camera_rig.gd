class_name CameraRig
extends Node3D
## Camara fija con dos modos:
##   side   -> vista lateral, sigue al jugador solo en X.
##   behind -> camara a la espalda del jugador (plano vertical).
## Se cambia con EventBus.camera_mode_requested.emit(&"side" / &"behind").

const PRESETS := {
	&"side": {"offset": Vector3(0, 2.0, 7.0), "look_offset": Vector3(0, 1.0, 0), "fov": 50.0},
	&"behind": {"offset": Vector3(0, 3.0, 5.0), "look_offset": Vector3(0, 1.0, -2.0), "fov": 60.0},
}

@export var follow_speed := 6.0
@export var min_x := -INF   # limites de camara en modo side
@export var max_x := INF

var _mode: StringName = &"side"
var _target: Node3D

@onready var _cam: Camera3D = $Camera3D


func _ready() -> void:
	_target = get_tree().get_first_node_in_group(&"player")
	EventBus.camera_mode_requested.connect(set_mode)


func set_mode(mode: StringName) -> void:
	if PRESETS.has(mode):
		_mode = mode


func snap() -> void:
	if _target == null:
		return
	var preset: Dictionary = PRESETS[_mode]
	_cam.global_position = _goal_position(preset)
	_cam.fov = preset["fov"]
	_aim(preset)


func _process(delta: float) -> void:
	if _target == null:
		return
	var preset: Dictionary = PRESETS[_mode]
	var t := clampf(follow_speed * delta, 0.0, 1.0)
	_cam.global_position = _cam.global_position.lerp(_goal_position(preset), t)
	_cam.fov = lerpf(_cam.fov, preset["fov"], t)
	_aim(preset)


func _goal_position(preset: Dictionary) -> Vector3:
	var offset: Vector3 = preset["offset"]
	var pos: Vector3 = _target.global_position + offset
	if _mode == &"side":
		pos.x = clampf(pos.x, min_x, max_x)
		pos.y = offset.y   # altura fija
	return pos


func _aim(preset: Dictionary) -> void:
	var look: Vector3 = _target.global_position + (preset["look_offset"] as Vector3)
	if _mode == &"side":
		look.x = _cam.global_position.x   # mira recto, sin girar
	if not _cam.global_position.is_equal_approx(look):
		_cam.look_at(look)
