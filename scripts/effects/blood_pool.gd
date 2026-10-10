class_name BloodPool
extends Node3D
## Charco de liquido rojo oscuro en el piso. Cada llamada a `spill()` lo hace mas grande.
## El charco se crea la primera vez justo bajo los pies del jugador y NO se mueve: queda en el mundo
## aunque el jugador se desplace. Es un efecto simple (disco plano con material brillante).

## Radio del charco (en metros) despues de cada derrame. El ultimo valor se repite si hay mas golpes.
@export var radii: PackedFloat32Array = [0.22, 0.38, 0.55, 0.72, 0.9]
@export var grow_time := 0.9

const FLOOR_LIFT := 0.02   # separacion con el piso para evitar parpadeo (z-fighting)

var _disc: MeshInstance3D
var _spills := 0


## `floor_pos` = posicion de los pies del jugador (origen del Player).
func spill(floor_pos: Vector3) -> void:
	if _disc == null:
		_disc = _make_disc()
		add_child(_disc)
		_disc.global_position = floor_pos + Vector3(0.0, FLOOR_LIFT, 0.0)
		_disc.scale = Vector3(0.02, 1.0, 0.02)
	var radius := radii[mini(_spills, radii.size() - 1)]
	_spills += 1
	var tween := create_tween()
	tween.tween_property(_disc, "scale", Vector3(radius, 1.0, radius * 0.85), grow_time)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _make_disc() -> MeshInstance3D:
	var mesh := CylinderMesh.new()
	mesh.top_radius = 1.0        # radio 1: el tamano real se da con la escala
	mesh.bottom_radius = 1.0
	mesh.height = 0.01
	mesh.radial_segments = 32
	mesh.rings = 1
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.25, 0.0, 0.02)
	mat.roughness = 0.12
	mat.metallic_specular = 0.9
	mat.emission_enabled = true
	mat.emission = Color(0.06, 0.0, 0.0)
	var disc := MeshInstance3D.new()
	disc.mesh = mesh
	disc.material_override = mat
	disc.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	return disc
