class_name LevelBase
extends Node3D
## Raiz de todos los niveles. Prepara el escenario importado de Blender (.glb) y coloca al jugador.
## Estructura esperada: Environment (el .glb), Spawns/Default (Marker3D), Player, CameraRig.

@export var level_id: StringName
@export_enum("side", "behind") var camera_mode: String = "side"
## Nodos del .glb cuyo nombre empieza asi se ocultan (puertas abiertas, obstaculos, carta...).
@export var hide_prefixes: PackedStringArray = []
## Mallas del .glb (o hijas de un nodo) cuyo nombre empieza asi reciben colision convexa.
@export var collision_prefixes: PackedStringArray = []
## Blender exporta las luces en unidades fisicas (candelas / lux): miles de unidades. Godot espera
## valores de ~0.5 a 6. Estas constantes convierten las luces importadas.
const POINT_LIGHT_SCALE := 0.001       # candelas -> energia de Godot (velas, antorchas, focos)
const SUN_LIGHT_SCALE := 0.0015        # lux -> energia de Godot (luz de luna)
const MAX_LIGHT_ENERGY := 5.0          # tope para que ninguna luz queme la imagen
const LIGHT_RANGE := 12.0              # alcance de velas y focos (el .glb no trae alcance)

## Tuneles de camara trasera: alarga el tunel hacia atras (+Z) esa cantidad de metros para que la
## camara tenga tunel detras del jugador. Se repiten las mallas `extend_tile_nodes` (tunel y piso,
## por nombre exacto) justo detras de si mismas, y las piezas `extend_move_prefixes` (la pared y la
## puerta del inicio) se corren al nuevo inicio. Un muro invisible impide al jugador retroceder.
@export var extend_back := 0.0
@export var extend_tile_nodes: PackedStringArray = []
@export var extend_move_prefixes: PackedStringArray = []

## Multiplicador extra para ajustar UN nivel: >1 mas luz, <1 mas oscuro.
@export var light_energy_scale := 1.0
## Las sombras de muchas luces son pesadas: por defecto estan apagadas.
@export var lights_cast_shadows := false


func _ready() -> void:
	GameState.current_level_id = level_id
	_prepare_environment()
	var player := get_tree().get_first_node_in_group(&"player") as Player
	var spawn := get_node_or_null("Spawns/%s" % String(SceneManager.next_spawn)) as Marker3D
	if spawn == null:
		spawn = get_node_or_null("Spawns/Default") as Marker3D
	if player and spawn:
		player.global_position = spawn.global_position
	if player:
		player.mode = StringName(camera_mode)   # directo, sin depender del orden de las senales
	EventBus.camera_mode_requested.emit(StringName(camera_mode))
	var rig := get_tree().get_first_node_in_group(&"camera_rig") as CameraRig
	if rig:
		rig.snap()
	print("[Nivel] %s | camara=%s | jugador.mode=%s" % [level_id, camera_mode, player.mode if player else &"(sin jugador)"])
	EventBus.level_started.emit(level_id)
	_on_level_ready()


## Para sobrescribir en cada nivel (eventos, timers, etc.)
func _on_level_ready() -> void:
	pass


# ---------- Ayudas para trabajar con el .glb ----------

## Busca un nodo del escenario importado por su nombre exacto.
func find_env_node(node_name: String) -> Node3D:
	var env := get_node_or_null("Environment")
	if env == null:
		return null
	var n := env.find_child(node_name, true, false) as Node3D
	if n == null:
		push_warning("%s: no existe el nodo '%s' en el escenario" % [level_id, node_name])
	return n


## Colision en forma de rampa (para escaleras: Godot no sube peldanos solo).
## from/to son (x, y) en el plano del nivel; z es la linea por la que camina el jugador.
func add_ramp(from: Vector2, to: Vector2, z: float, width: float, thickness: float = 0.2) -> void:
	var body := StaticBody3D.new()
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	var delta := to - from
	box.size = Vector3(delta.length(), thickness, width)
	shape.shape = box
	body.add_child(shape)
	add_child(body)
	var angle := atan2(delta.y, delta.x)
	var mid := (from + to) * 0.5
	var normal := Vector2(-sin(angle), cos(angle))
	var center := mid - normal * (thickness * 0.5)
	body.position = Vector3(center.x, center.y, z)
	body.rotation.z = angle


func _prepare_environment() -> void:
	var env := get_node_or_null("Environment")
	if env == null:
		return
	# Nuestra camara es CameraRig: se descartan las camaras que trae Blender.
	for cam in env.find_children("*", "Camera3D", true, false):
		cam.queue_free()
	_extend_tunnel(env)
	for node in env.find_children("*", "Node3D", true, false):
		if _starts_with_any(node.name, hide_prefixes):
			node.visible = false
	for light in env.find_children("*", "Light3D", true, false):
		var base := SUN_LIGHT_SCALE if light is DirectionalLight3D else POINT_LIGHT_SCALE
		light.light_energy = minf(light.light_energy * base, MAX_LIGHT_ENERGY) * light_energy_scale
		light.shadow_enabled = lights_cast_shadows
		if light is OmniLight3D:
			light.omni_range = LIGHT_RANGE
		elif light is SpotLight3D:
			light.spot_range = LIGHT_RANGE
	if collision_prefixes.is_empty():
		return
	for mesh in env.find_children("*", "MeshInstance3D", true, false):
		if _chain_matches(mesh, env, collision_prefixes) and mesh.is_visible_in_tree():
			mesh.create_convex_collision(true, false)


## Alarga el tunel hacia atras (ver `extend_back`).
func _extend_tunnel(env: Node) -> void:
	if extend_back <= 0.0:
		return
	for node_name in extend_tile_nodes:
		var src := env.find_child(node_name, true, false) as MeshInstance3D
		if src == null:
			push_warning("%s: no existe la malla '%s' para alargar el tunel" % [level_id, node_name])
			continue
		var length := (src.global_transform * src.get_aabb()).size.z
		var copy := src.duplicate() as MeshInstance3D
		src.get_parent().add_child(copy)
		copy.global_transform = src.global_transform
		copy.global_position.z += length     # pegada al inicio del tunel original, sin traslape
	for node in env.find_children("*", "Node3D", true, false):
		if _starts_with_any(node.name, extend_move_prefixes) and not _chain_matches(node.get_parent(), env, extend_move_prefixes):
			node.global_position.z += extend_back


func _starts_with_any(node_name: String, prefixes: PackedStringArray) -> bool:
	for p in prefixes:
		if node_name.begins_with(p):
			return true
	return false


func _chain_matches(node: Node, root: Node, prefixes: PackedStringArray) -> bool:
	var n := node
	while n != null and n != root:
		if _starts_with_any(n.name, prefixes):
			return true
		n = n.get_parent()
	return false
