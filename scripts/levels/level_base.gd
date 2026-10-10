class_name LevelBase
extends Node3D
## Raiz de todos los niveles. Coloca al jugador en el spawn, fija el modo de camara.
## Estructura esperada: Spawns/Default (Marker3D), Player, CameraRig.

@export var level_id: StringName
@export_enum("side", "behind") var camera_mode: String = "side"


func _ready() -> void:
	GameState.current_level_id = level_id
	var player := get_tree().get_first_node_in_group(&"player") as Player
	var spawn := get_node_or_null("Spawns/%s" % String(SceneManager.next_spawn)) as Marker3D
	if spawn == null:
		spawn = get_node_or_null("Spawns/Default") as Marker3D
	if player and spawn:
		player.global_position = spawn.global_position
	EventBus.camera_mode_requested.emit(StringName(camera_mode))
	var rig := get_tree().get_first_node_in_group(&"camera_rig") as CameraRig
	if rig:
		rig.snap()
	EventBus.level_started.emit(level_id)
	_on_level_ready()


## Para sobrescribir en cada nivel (eventos, timers, etc.)
func _on_level_ready() -> void:
	pass
