class_name FireEffect
extends Node3D
## Llamas procedurales para prender en fuego a un personaje: particulas (CPUParticles3D, funcionan en
## cualquier renderizador) mas una luz naranja que parpadea. Se pone como hijo del personaje y se
## llama `ignite()`. Cubre una caja de `body_size` metros centrada en el origen del nodo (pies en y = 0).

@export var body_size := Vector3(1.0, 2.0, 0.6)
@export var light_energy := 3.0

var _light: OmniLight3D
var _burning := false
var _time := 0.0


func ignite() -> void:
	if _burning:
		return
	_burning = true
	var flames := CPUParticles3D.new()
	flames.amount = 160
	flames.lifetime = 1.1
	flames.local_coords = false          # las llamas se quedan en el aire si el personaje se mueve
	flames.position = Vector3(0.0, body_size.y * 0.5, 0.0)
	flames.emission_shape = CPUParticles3D.EMISSION_SHAPE_BOX
	flames.emission_box_extents = body_size * 0.5
	flames.direction = Vector3.UP
	flames.spread = 12.0
	flames.gravity = Vector3(0.0, 1.8, 0.0)
	flames.initial_velocity_min = 0.4
	flames.initial_velocity_max = 1.4
	flames.scale_amount_min = 0.7
	flames.scale_amount_max = 1.3
	var shrink := Curve.new()
	shrink.add_point(Vector2(0.0, 0.8))
	shrink.add_point(Vector2(1.0, 0.0))
	flames.scale_amount_curve = shrink
	var colors := Gradient.new()
	colors.set_color(0, Color(1.0, 0.9, 0.35, 0.9))     # centro amarillo
	colors.set_color(1, Color(0.8, 0.05, 0.0, 0.0))     # punta roja que se desvanece
	colors.add_point(0.4, Color(1.0, 0.45, 0.05, 0.8))  # naranja
	flames.color_ramp = colors
	flames.mesh = _flame_mesh()
	add_child(flames)

	_light = OmniLight3D.new()
	_light.light_color = Color(1.0, 0.5, 0.15)
	_light.omni_range = 9.0
	_light.light_energy = light_energy
	_light.position = Vector3(0.0, body_size.y * 0.6, 0.4)
	add_child(_light)


func _flame_mesh() -> QuadMesh:
	var texture := GradientTexture2D.new()          # mancha suave y redonda
	texture.fill = GradientTexture2D.FILL_RADIAL
	texture.fill_from = Vector2(0.5, 0.5)
	texture.fill_to = Vector2(0.5, 0.0)
	var soft := Gradient.new()
	soft.set_color(0, Color.WHITE)
	soft.set_color(1, Color(1, 1, 1, 0))
	texture.gradient = soft
	texture.width = 64
	texture.height = 64
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
	material.billboard_mode = BaseMaterial3D.BILLBOARD_PARTICLES
	material.vertex_color_use_as_albedo = true
	material.albedo_texture = texture
	material.no_depth_test = false
	var quad := QuadMesh.new()
	quad.size = Vector2(0.7, 0.7)
	quad.material = material
	return quad


func _process(delta: float) -> void:
	if _light == null:
		return
	_time += delta
	_light.light_energy = light_energy * (0.75 + 0.25 * sin(_time * 23.0) + randf_range(-0.15, 0.15))
