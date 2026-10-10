class_name Player
extends CharacterBody3D
## Malaes. Convencion: el modelo mira hacia -Z.
## Modo SIDE: solo se mueve en X (vista lateral).
## Modo BEHIND: se mueve en X/Z con camara a la espalda (W = avanzar hacia -Z).

@export var walk_speed := 2.5
@export var run_speed := 5.0
@export var jump_velocity := 4.5
@export var can_run := false     # se activa en la persecucion
@export var can_jump := false    # se activa en la persecucion
@export var acceleration := 20.0
@export var turn_speed := 12.0
@export var allow_backwards := true   # en el camino final no se puede retroceder

var mode: StringName = &"side"

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var _nearby: Array[Interactable] = []
var _current: Interactable
var _shown_prompt := ""

@onready var _pivot: Node3D = $ModelPivot
@onready var _sensor: Area3D = $InteractionSensor


func _ready() -> void:
	_sensor.area_entered.connect(_on_area_entered)
	_sensor.area_exited.connect(_on_area_exited)
	EventBus.camera_mode_requested.connect(func(m: StringName) -> void: mode = m)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

	var dir := Vector3.ZERO
	if not GameState.is_input_locked():
		dir = _read_direction()
		if can_jump and is_on_floor() and Input.is_action_just_pressed(&"jump"):
			velocity.y = jump_velocity

	var running := can_run and Input.is_action_pressed(&"sprint") and dir != Vector3.ZERO
	var speed := run_speed if running else walk_speed
	velocity.x = move_toward(velocity.x, dir.x * speed, acceleration * delta)
	velocity.z = move_toward(velocity.z, dir.z * speed, acceleration * delta)
	move_and_slide()

	_update_facing(dir, delta)
	_update_interaction()


func _read_direction() -> Vector3:
	var x := Input.get_axis(&"move_left", &"move_right")
	if mode == &"behind":
		var z := Input.get_axis(&"move_forward", &"move_back")   # adelante = -Z
		if not allow_backwards:
			z = minf(z, 0.0)
		return Vector3(x, 0.0, z).normalized()
	return Vector3(x, 0.0, 0.0)


func _update_facing(dir: Vector3, delta: float) -> void:
	if dir.length() < 0.1:
		return
	var target_yaw := atan2(-dir.x, -dir.z)
	_pivot.rotation.y = lerp_angle(_pivot.rotation.y, target_yaw, clampf(turn_speed * delta, 0.0, 1.0))


func _update_interaction() -> void:
	var best: Interactable = null
	var best_d := INF
	for item in _nearby:
		if is_instance_valid(item) and item.can_interact():
			var d := global_position.distance_squared_to(item.global_position)
			if d < best_d:
				best_d = d
				best = item
	_current = best
	var wanted := ("[E] " + best.prompt_text) if best else ""
	if wanted != _shown_prompt:
		_shown_prompt = wanted
		EventBus.prompt_changed.emit(wanted)
	if _current and not GameState.is_input_locked() and Input.is_action_just_pressed(&"interact"):
		_current.interact(self)


func _on_area_entered(area: Area3D) -> void:
	if area is Interactable:
		_nearby.append(area)


func _on_area_exited(area: Area3D) -> void:
	if area is Interactable:
		_nearby.erase(area)
