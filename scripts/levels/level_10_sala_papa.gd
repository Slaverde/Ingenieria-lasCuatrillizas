extends LevelBase
## Escenario 7: el Papa. Malaes y Lilith (a su lado) caminan libremente por la sala y suben la escalinata
## hasta quedar cerca del Papa; recien ahi empiezan los dialogos. Al final el Papa se prende en llamas
## ("ALABADO SEA SAMAEL", 5 s) y una pantalla negra dice "AHORA TU ERES EL HEREDERO... EL PAPA".
## TODO: primer plano de Malaes con la corona, creditos.

const ARRIVAL_Z := -47.0          # al cruzar esta linea (arriba de la escalinata) arrancan los dialogos
const STAIRS_START_Z := -43.4     # pie de la escalinata (Grada_0 empieza en z = -44)
const STAIRS_END_Z := -48.2       # el ultimo peldano (Grada_7) queda a 2.4 m de altura
const STAIRS_TOP := 2.4
const ROOM_WIDTH := 15.0          # ancho entre los muros invisibles
const ROOM_END_Z := -59.5

var _arrived := false


func _on_level_ready() -> void:
	_build_stairs()
	_build_arrival_zone()
	EventBus.objective_changed.emit("Avanza hacia el Papa")


## Colision de la escalinata (Godot no sube peldanos solo): una rampa por la linea de las narices
## de los peldanos y un piso plano en la plataforma donde esta el Papa.
func _build_stairs() -> void:
	add_ramp_z(Vector2(STAIRS_START_Z, 0.0), Vector2(STAIRS_END_Z, STAIRS_TOP), 0.0, ROOM_WIDTH)
	var floor_body := StaticBody3D.new()
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	var length := STAIRS_END_Z - ROOM_END_Z   # 11.3 m de plataforma
	box.size = Vector3(ROOM_WIDTH, 0.2, length)
	shape.shape = box
	floor_body.add_child(shape)
	add_child(floor_body)
	floor_body.global_position = Vector3(0.0, STAIRS_TOP - 0.1, STAIRS_END_Z - length * 0.5)


func _build_arrival_zone() -> void:
	var zone := Area3D.new()
	zone.collision_layer = 0
	zone.collision_mask = 8   # solo el jugador
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = Vector3(ROOM_WIDTH, 8.0, 1.0)
	shape.shape = box
	zone.add_child(shape)
	add_child(zone)
	zone.global_position = Vector3(0.0, 3.0, ARRIVAL_Z)
	zone.body_entered.connect(_on_arrival)


func _on_arrival(body: Node3D) -> void:
	if _arrived or not body is Player:
		return
	_arrived = true
	EventBus.objective_changed.emit("")
	GameState.lock_input(&"final")
	await get_tree().create_timer(0.8).timeout   # Malaes y Lilith se detienen frente al Papa
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("papa_final"))
	await EventBus.dialogue_finished
	# El Papa se prende en llamas mientras grita "ALABADO SEA SAMAEL" (linea automatica de 5 s)
	var fire := FireEffect.new()
	fire.body_size = Vector3(1.0, 2.1, 0.6)
	$Papa.add_child(fire)
	fire.ignite()
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("papa_llamas"))
	await EventBus.dialogue_finished
	await _pantalla_final()
	GameState.set_flag(&"fin_del_juego")


## Pantalla negra que cubre todo (tambien el HUD) con el mensaje final. Las llamas siguen detras.
func _pantalla_final() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 100
	add_child(layer)
	var cover := ColorRect.new()
	cover.color = Color.BLACK
	cover.set_anchors_preset(Control.PRESET_FULL_RECT)
	cover.modulate.a = 0.0
	layer.add_child(cover)
	var label := Label.new()
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", 56)
	label.add_theme_color_override("font_color", Color(0.85, 0.08, 0.06))
	label.text = "AHORA TÚ ERES EL HEREDERO,"
	label.modulate.a = 0.0
	layer.add_child(label)
	var fade := create_tween()
	fade.tween_property(cover, "modulate:a", 1.0, 1.5)
	await fade.finished
	var first := create_tween()
	first.tween_property(label, "modulate:a", 1.0, 1.0)
	await first.finished
	await get_tree().create_timer(2.0).timeout
	label.text = "AHORA TÚ ERES EL HEREDERO,\nAHORA TÚ ERES... EL PAPA"
	await get_tree().create_timer(3.0).timeout
