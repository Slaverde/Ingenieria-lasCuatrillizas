extends LevelBase
## Escenario 4 (catacumbas): libros (carta en latin), altar para rezar y la puerta de los 3 santos.
##
## Orden de la escena:
##  1. Libros: Malaes recoge la carta en latin, no la entiende y la guarda (flag carta_latin_guardada).
##  2. Altar -> "Rezar": 5 s de luces rojas intermitentes mientras suena la frase en latin; despues
##     Malaes dice que entendio todo (flag entendio_latin).
##  3. Al llegar a la puerta final salta el dialogo (flag puerta_carta_lista): "¿Sera esta la puerta que
##     menciono Lilith?", "tres santos", "A menos que...", y luego "ESPERA! la carta estaba en latin". Aparece
##     "Sacar la carta" con [E]: se muestra la carta ya traducida (flag carta_descifrada).
##  4. Solo entonces la puerta se puede abrir con [E] (pasa al escenario siguiente).
## TODO: temblor de pantalla al rezar, animacion de la puerta.

const FRENZY_SECONDS := 5.0
const FRENZY_RED := Color(1.0, 0.04, 0.02)
const FRENZY_LIGHT_ENERGY := 5.0
const FRENZY_AMBIENT := Color(0.6, 0.03, 0.03)

@onready var _libros: Interactable = $Biblioteca
@onready var _altar: Interactable = $Altar
@onready var _puerta: Interactable = $PuertaTresDiablos


func _on_level_ready() -> void:
	var carta := find_env_node("Carta_Latin")
	if carta:
		_libros.global_position = carta.global_position + Vector3(0, 0.5, 0)
	_altar.interacted.connect(func(_p: Node3D) -> void: _rezar())
	_puerta.interacted.connect(_on_puerta)
	_crear_zona_puerta()
	_refresh_prompt()


# ---------- Altar: rezar ----------

func _rezar() -> void:
	GameState.lock_input(&"ritual")
	var estado := {"dialogo_listo": false}   # Dictionary: una lambda no puede cambiar variables locales simples
	EventBus.dialogue_finished.connect(func() -> void: estado["dialogo_listo"] = true, CONNECT_ONE_SHOT)
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("rezar_altar"))   # linea automatica de 5 s
	await _frenesi_de_luces(FRENZY_SECONDS)
	while not estado["dialogo_listo"]:
		await get_tree().process_frame
	# Termino el frenesi: ahora si hablan los pensamientos de Malaes
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("rezar_protagonista"))
	await EventBus.dialogue_finished
	GameState.set_flag(&"entendio_latin")
	GameState.unlock_input(&"ritual")


## Luces rojas intermitentes alrededor del jugador (y la luz ambiente) durante `seconds`.
func _frenesi_de_luces(seconds: float) -> void:
	var player := get_tree().get_first_node_in_group(&"player") as Node3D
	var world := get_node_or_null("WorldEnvironment") as WorldEnvironment
	var old_ambient_color := Color.BLACK
	var old_ambient_energy := 0.0
	if world and world.environment:
		old_ambient_color = world.environment.ambient_light_color
		old_ambient_energy = world.environment.ambient_light_energy
	var lights: Array[OmniLight3D] = []
	for dz in [-3.5, 0.0, 3.5]:
		var light := OmniLight3D.new()
		light.light_color = FRENZY_RED
		light.light_energy = 0.0
		light.omni_range = 9.0
		add_child(light)
		light.global_position = player.global_position + Vector3(0.0, 2.2, dz)
		lights.append(light)
	var elapsed := 0.0
	while elapsed < seconds and is_inside_tree():
		var any_on := false
		for light in lights:
			var on := randf() > 0.45
			light.light_energy = FRENZY_LIGHT_ENERGY if on else 0.0
			any_on = any_on or on
		if world and world.environment:
			world.environment.ambient_light_color = FRENZY_AMBIENT if any_on else old_ambient_color
			world.environment.ambient_light_energy = 0.9 if any_on else old_ambient_energy
		var step := minf(randf_range(0.07, 0.2), seconds - elapsed)
		await get_tree().create_timer(step).timeout
		elapsed += step
	for light in lights:
		light.queue_free()
	if world and world.environment:
		world.environment.ambient_light_color = old_ambient_color
		world.environment.ambient_light_energy = old_ambient_energy


# ---------- Puerta final ----------

## Zona frente a la puerta: al entrar (ya habiendo rezado y guardado la carta) salta "ESPERA!".
func _crear_zona_puerta() -> void:
	var zone := Area3D.new()
	zone.collision_layer = 0
	zone.collision_mask = 8   # solo el jugador
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = Vector3(4.6, 3.0, 3.0)
	shape.shape = box
	zone.add_child(shape)
	add_child(zone)
	zone.global_position = _puerta.global_position + Vector3(0.0, 0.0, 1.0)
	zone.body_entered.connect(_on_zona_puerta)


func _on_zona_puerta(body: Node3D) -> void:
	if not body is Player:
		return
	if GameState.get_flag(&"puerta_carta_lista") or not GameState.get_flag(&"entendio_latin") \
			or not GameState.get_flag(&"carta_latin_guardada"):
		return
	GameState.set_flag(&"puerta_carta_lista")
	GameState.set_flag(&"vio_puerta_3_diablos")   # ya hablo de la puerta: no repetir el dialogo de "Examinar"
	# "¿Sera esta la puerta de Lilith?" / "tres santos" / "A menos que..." y enseguida lo de la carta
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("puerta_espera"))
	await EventBus.dialogue_finished
	_refresh_prompt()


func _on_puerta(_player: Node3D) -> void:
	if GameState.get_flag(&"carta_descifrada"):
		SceneManager.change_level(&"06_encuentro_lilith")
	elif GameState.get_flag(&"puerta_carta_lista"):
		GameState.set_flag(&"carta_descifrada")
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("carta_latin_legible"))
		await EventBus.dialogue_finished
		_refresh_prompt()   # ahora la puerta se puede abrir con [E]
	elif not GameState.get_flag(&"vio_puerta_3_diablos"):
		GameState.set_flag(&"vio_puerta_3_diablos")
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("puerta_3_diablos"))
		await EventBus.dialogue_finished
		_refresh_prompt()
	else:
		EventBus.dialogue_requested.emit(DialogueDB.load_lines("puerta_sin_carta"))


func _refresh_prompt() -> void:
	if GameState.get_flag(&"carta_descifrada"):
		_puerta.prompt_text = "Abrir la puerta"
	elif GameState.get_flag(&"puerta_carta_lista"):
		_puerta.prompt_text = "Sacar la carta"
	else:
		_puerta.prompt_text = "Examinar la puerta"
