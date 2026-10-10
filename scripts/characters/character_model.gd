class_name CharacterModel
extends Node3D
## Modelo de personaje importado de Blender (.glb con esqueleto y SIN animaciones).
## Los .glb vienen en T-pose: este script baja los brazos y, al caminar, los balancea con un
## pequeno rebote del cuerpo. Todo se calcula por codigo sobre el esqueleto (hasta que haya
## animaciones reales en los .glb: `idle`, `walk`, etc., ver assets/README.md).
## El modelo se instancia como hijo ("Model") ya girado hacia -Z, que es hacia donde mira el juego.

@export var arm_drop_deg := 72.0        # cuanto bajan los brazos desde la T-pose
@export var right_arm_drop_deg := -1.0  # si es >= 0, el brazo derecho baja esto en vez de arm_drop_deg (ej. Papa con baculo)
@export var upright_right_hand := false # la mano derecha se mantiene en su orientacion original (para sostener un baculo vertical)
@export var arm_swing_deg := 16.0       # balanceo de los brazos al caminar
@export var bob_height := 0.025         # rebote vertical al caminar (metros, antes de la escala)
@export var steps_per_meter := 1.6      # ritmo del paso segun la velocidad

var _skeleton: Skeleton3D
var _arm_bones := {}            # lado (+1 izquierdo / -1 derecho) -> indice de hueso
var _hand_r := -1
var _base_y := 0.0
var _phase := 0.0
var _move := 0.0                # 0 = quieto, 1 = caminando (suavizado)
var _target_move := 0.0
var _speed := 0.0


func _ready() -> void:
	_base_y = position.y
	var skeletons := find_children("*", "Skeleton3D", true, false)
	if skeletons.is_empty():
		push_warning("CharacterModel '%s': el modelo no tiene esqueleto" % name)
		return
	_skeleton = skeletons[0] as Skeleton3D
	_face_minus_z()
	_arm_bones[1.0] = _find_bone("upperarm", "l")
	_arm_bones[-1.0] = _find_bone("upperarm", "r")
	if upright_right_hand:
		_hand_r = _find_bone("hand", "r")
	_apply_pose()


## Gira el modelo (hijo "Model") para que MIRE HACIA -Z, que es "hacia adelante" en el juego.
## No se asume hacia donde mira el .glb: se mide con los huesos (la punta del pie esta delante del tobillo),
## asi funciona sin importar como lo exporte Blender o lo importe Godot.
func _face_minus_z() -> void:
	var model := get_node_or_null("Model") as Node3D
	var toe := _find_bone("toe", "l")
	var foot := _find_bone("foot", "l")
	if model == null or toe < 0 or foot < 0:
		return
	var skeleton_in_self := global_transform.affine_inverse() * _skeleton.global_transform
	var forward := skeleton_in_self.basis * (_skeleton.get_bone_global_rest(toe).origin - _skeleton.get_bone_global_rest(foot).origin)
	if forward.z > 0.0:
		model.rotate_y(PI)
		print("[Modelo] %s miraba a +Z: girado 180 grados para mirar a -Z" % name)
	else:
		print("[Modelo] %s ya mira a -Z" % name)


## Lo llama el jugador/NPC cada frame con su velocidad horizontal (m/s).
func set_move_speed(speed: float) -> void:
	_speed = speed
	_target_move = 1.0 if speed > 0.1 else 0.0


func _process(delta: float) -> void:
	if _skeleton == null:
		return
	_move = move_toward(_move, _target_move, delta * 6.0)
	if _move > 0.0:
		_phase += delta * _speed * steps_per_meter * TAU * 0.5
	position.y = _base_y + absf(sin(_phase)) * bob_height * _move
	_apply_pose()


func _apply_pose() -> void:
	var swing := sin(_phase) * arm_swing_deg * _move
	for side in _arm_bones:
		var bone: int = _arm_bones[side]
		if bone < 0:
			continue
		# El brazo izquierdo esta en +X y el derecho en -X: se giran en sentido contrario.
		# Los brazos se balancean uno contra otro (swing * side).
		var drop_deg := arm_drop_deg
		if side < 0.0 and right_arm_drop_deg >= 0.0:
			drop_deg = right_arm_drop_deg
		var drop := Basis(Vector3.BACK, deg_to_rad(drop_deg) * -side)
		var forward := Basis(Vector3.RIGHT, deg_to_rad(swing) * side)
		var parent := _skeleton.get_bone_parent(bone)
		var parent_basis := Basis.IDENTITY
		if parent >= 0:
			parent_basis = _skeleton.get_bone_global_pose(parent).basis
		var rest_global := _skeleton.get_bone_global_rest(bone).basis
		var local := parent_basis.inverse() * forward * drop * rest_global
		_skeleton.set_bone_pose_rotation(bone, local.get_rotation_quaternion())
	if _hand_r >= 0:
		# La mano contrarresta el giro del brazo y queda como en la T-pose: el baculo sigue vertical
		var hand_parent := _skeleton.get_bone_parent(_hand_r)
		var parent_pose := _skeleton.get_bone_global_pose(hand_parent).basis
		var hand_rest := _skeleton.get_bone_global_rest(_hand_r).basis
		_skeleton.set_bone_pose_rotation(_hand_r, (parent_pose.inverse() * hand_rest).get_rotation_quaternion())


## Busca un hueso por nombre sin importar mayusculas, puntos ni guiones bajos ("UpperArm.L" == "upperarm_l").
func _find_bone(base: String, side: String) -> int:
	var wanted := base + side
	for i in _skeleton.get_bone_count():
		var n := _skeleton.get_bone_name(i).to_lower().replace(".", "").replace("_", "").replace(" ", "")
		if n == wanted:
			return i
	push_warning("CharacterModel '%s': no se encontro el hueso %s %s" % [name, base, side])
	return -1
