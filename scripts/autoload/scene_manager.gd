extends Node
## Cambia de nivel con fundido a negro. Usa IDs de LevelRegistry, no rutas.

const FADE_TIME := 0.5

var next_spawn: StringName = &"Default"   # lo lee LevelBase al cargar
var _busy := false
var _overlay: ColorRect


func _ready() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 100
	add_child(layer)
	_overlay = ColorRect.new()
	_overlay.color = Color(0, 0, 0, 0)
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(_overlay)
	EventBus.player_died.connect(_on_player_died)


func change_level(level_id: StringName, spawn: StringName = &"Default") -> void:
	if _busy:
		return
	var path := LevelRegistry.path_of(level_id)
	if path == "":
		push_error("SceneManager: nivel desconocido '%s'" % level_id)
		return
	_busy = true
	GameState.lock_input(&"transition")
	await fade_to(1.0)
	next_spawn = spawn
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await get_tree().process_frame
	await fade_to(0.0)
	GameState.unlock_input(&"transition")
	_busy = false


func restart_level() -> void:
	change_level(GameState.current_level_id, &"Default")


func fade_to(alpha: float, time: float = FADE_TIME) -> void:
	var tween := create_tween()
	tween.tween_property(_overlay, "color:a", alpha, time)
	await tween.finished


func _on_player_died() -> void:
	await get_tree().create_timer(1.5).timeout
	restart_level()
