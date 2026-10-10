class_name Monja
extends Node3D
## La monja del escenario 2. Aparece por la puerta, regana a Malaes y despues lo GUIA:
## camina hacia la derecha y espera si el jugador se queda atras. Al llegar al final sale de escena.
## El modelo es assets/characters/monja/monja.glb (ver monja_model.tscn); se gira con ModelPivot.

signal left_scene

@export var walk_speed := 2.2        # un poco menos que el jugador (2.5) para que la alcance
@export var wait_distance := 3.5     # si el jugador queda mas atras que esto, ella espera

var _player: Node3D

@onready var _pivot: Node3D = $ModelPivot
@onready var _model: CharacterModel = $ModelPivot/MonjaModel as CharacterModel


func _ready() -> void:
	_player = get_tree().get_first_node_in_group(&"player")
	visible = false


## Entra caminando desde `from_pos` y se detiene en `to_pos`, frente al jugador.
func appear(from_pos: Vector3, to_pos: Vector3) -> void:
	global_position = from_pos
	look_toward(to_pos.x - from_pos.x)
	visible = true
	_model.set_move_speed(walk_speed)
	var tween := create_tween()
	tween.tween_property(self, "global_position", to_pos, maxf(from_pos.distance_to(to_pos) / walk_speed, 0.1))
	await tween.finished
	_model.set_move_speed(0.0)


## Gira hacia +X (direction > 0) o -X (direction < 0). El modelo mira hacia -Z por convencion.
func look_toward(direction: float) -> void:
	if absf(direction) > 0.01:
		_pivot.rotation.y = atan2(-signf(direction), 0.0)


## Camina hacia la derecha hasta `end_x` guiando al jugador; luego desaparece.
func lead_to(end_x: float) -> void:
	look_toward(1.0)
	while is_inside_tree() and global_position.x < end_x:
		var waiting := _player != null and global_position.x - _player.global_position.x > wait_distance
		_model.set_move_speed(0.0 if waiting else walk_speed)
		if not waiting:
			global_position.x = move_toward(global_position.x, end_x, walk_speed * get_process_delta_time())
		await get_tree().process_frame
	_model.set_move_speed(0.0)
	visible = false
	left_scene.emit()
