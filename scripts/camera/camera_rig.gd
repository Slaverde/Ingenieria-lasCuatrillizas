class_name CameraRig
extends Node3D
## Camara fija con dos modos:
##   side   -> vista lateral, sigue al jugador solo en X.
##   behind -> camara a la espalda del jugador (plano vertical).
## Se cambia con EventBus.camera_mode_requested.emit(&"side" / &"behind").
## offset_bias / look_bias permiten ajustar la camara en cada nivel (salas altas o profundas).

const PRESETS := {
	&"side": {"offset": Vector3(0, 2.0, 7.0), "look_offset": Vector3(0, 1.0, 0), "fov": 50.0},
	&"behind": {"offset": Vector3(0, 3.0, 5.0), "look_offset": Vector3(0, 1.0, -2.0), "fov": 60.0},
}

@export var follow_speed := 6.0
@export var min_x := -INF   # limites de camara en modo side
@export var max_x := INF
@export var offset_bias := Vector3.ZERO
@export var look_bias := Vector3.ZERO
## En modo behind la camara no puede atravesar las paredes: un rayo desde el jugador hacia la
## camara la acerca si choca con la fisica del mundo (capa 1: paredes, muros invisibles, altares).
@export var avoid_walls := true

const WALL_MARGIN := 0.35    # separacion entre la camara y la pared
const MIN_ARM := 1.2         # distancia minima jugador-camara
const ARM_ORIGIN := Vector3(0, 1.2, 0)   # el rayo sale de la altura de la cabeza

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
	var offset: Vector3 = (preset["offset"] as Vector3) + offset_bias
	var pos: Vector3 = _target.global_position + offset
	if _mode == &"side":
		pos.x = clampf(pos.x, min_x, max_x)
		pos.y = offset.y   # altura fija
	elif avoid_walls:
		pos = _keep_inside(pos)
	return pos


## Acerca la camara al jugador si entre ambos hay una pared (evita verla desde fuera del cuarto).
func _keep_inside(goal: Vector3) -> Vector3:
	var from := _target.global_position + ARM_ORIGIN
	var query := PhysicsRayQueryParameters3D.create(from, goal, 1)
	if _target is CollisionObject3D:
		query.exclude = [(_target as CollisionObject3D).get_rid()]
	var hit := _target.get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return goal
	var arm := from.distance_to(goal)
	var free := from.distance_to(hit["position"] as Vector3) - WALL_MARGIN
	return from + (goal - from) / arm * clampf(free, minf(MIN_ARM, arm), arm)


func _aim(preset: Dictionary) -> void:
	var look: Vector3 = _target.global_position + (preset["look_offset"] as Vector3) + look_bias
	if _mode == &"side":
		look.x = _cam.global_position.x   # mira recto, sin girar
	if not _cam.global_position.is_equal_approx(look):
		_cam.look_at(look)
