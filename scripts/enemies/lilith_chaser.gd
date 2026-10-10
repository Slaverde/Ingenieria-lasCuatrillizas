class_name LilithChaser
extends CharacterBody3D
## Lilith monstruo en la persecucion (camara a la espalda). Avanza hacia -Z siguiendo al jugador.
## Si lo alcanza -> player_died. Layer 3 = enemigos.
## TODO: animacion de despedazar, dialogos mientras corre, ritmo segun obstaculos.

@export var speed := 4.0
@export var catch_distance := 1.0

var _target: Node3D
var active := false


func _ready() -> void:
	collision_layer = 4
	collision_mask = 1
	_target = get_tree().get_first_node_in_group(&"player")


func _physics_process(delta: float) -> void:
	if not active or _target == null:
		return
	var to_target := _target.global_position - global_position
	to_target.y = 0.0
	if to_target.length() <= catch_distance:
		active = false
		EventBus.player_died.emit()
		return
	velocity = to_target.normalized() * speed
	move_and_slide()
