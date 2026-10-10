extends LevelBase
## Escenario 3: el mismo cuarto, pero con la cruz invertida y la puerta abierta desde el inicio.
## La luz del cuarto es rojiza y Malaes comenta la cruz al aparecer.
## TODO: animacion de levantarse de la cama.

const RED_LIGHT := Color(1.0, 0.12, 0.08)
const RED_AMBIENT := Color(0.32, 0.04, 0.04)
const TINT_AMOUNT := 0.85         # 0 = luz original, 1 = rojo puro
const AMBIENT_ENERGY := 0.4


func _on_level_ready() -> void:
	var cruz := find_env_node("Cruz")
	if cruz:
		cruz.rotate_z(PI)   # el pivote de la cruz esta en su centro
	_tint_room_red()
	_comentar_cruz()


## Pone toda la luz del cuarto rojiza: las luces del .glb y la luz ambiente.
func _tint_room_red() -> void:
	var env_node := get_node_or_null("Environment")
	if env_node:
		for light in env_node.find_children("*", "Light3D", true, false):
			light.light_color = light.light_color.lerp(RED_LIGHT, TINT_AMOUNT)
	var world := get_node_or_null("WorldEnvironment") as WorldEnvironment
	if world and world.environment:
		world.environment.ambient_light_color = RED_AMBIENT
		world.environment.ambient_light_energy = AMBIENT_ENERGY


## Malaes nota la cruz invertida (una sola vez, cuando termina el fundido de entrada).
func _comentar_cruz() -> void:
	if GameState.get_flag(&"comento_cruz"):
		return
	while GameState.is_input_locked():
		await get_tree().process_frame
	await get_tree().create_timer(0.6).timeout
	GameState.set_flag(&"comento_cruz")
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("cruz_invertida"))
