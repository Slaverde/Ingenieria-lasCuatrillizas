extends LevelBase
## Escenario 2: Lilith llorando, conversacion tras la puerta, la monja descubre a Malaes
## y lo castiga (5 pulsaciones de E). Despues la monja lo GUIA: aparece el letrero
## "Sigue a la monja", ella sale por la derecha y al tocar la pared derecha se cambia de escena.
## El castigo NO se muestra de forma explicita: solo el contador y el charco que crece en el piso.
## Despues de hablar con Lilith, ella sale corriendo hacia la izquierda y desaparece.
## TODO: efectos de camara/sonido, modelo final de la monja, pasillos repetidos.

const NUN_ENTRY_X := 36.0         # la monja entra a escena por el extremo derecho del pasillo
const NUN_OFFSET := 1.6           # la monja se para a la derecha del jugador
const LILITH_EXIT_X := -2.0       # Lilith huye hacia la izquierda hasta salir de escena
const LILITH_RUN_SPEED := 8.0     # m/s (rapido)
const NUN_END_X := 36.0           # al llegar aqui sale de escena (la pared derecha esta en 36.4)

@onready var _castigo: FlagellationMinigame = $Castigo
@onready var _monja: Monja = $Monja
@onready var _sangre: BloodPool = $Sangre
@onready var _lilith: Interactable = $Lilith
@onready var _escuchar: Interactable = $EscucharPuerta

var _escena_iniciada := false


func _on_level_ready() -> void:
	_castigo.hit.connect(_on_castigo_golpe)
	_castigo.completed.connect(_on_castigo_completado)
	_lilith.interacted.connect(_on_lilith_hablada)
	EventBus.flag_changed.connect(_on_flag)
	if GameState.get_flag(&"escucho_conversacion"):
		_escuchar.enabled = false   # al volver al nivel no se repite la escena


## Al terminar el dialogo con Lilith, ella huye corriendo hacia la izquierda hasta desaparecer.
func _on_lilith_hablada(_player: Node3D) -> void:
	await EventBus.dialogue_finished
	await get_tree().create_timer(0.3).timeout
	var distance := absf(_lilith.global_position.x - LILITH_EXIT_X)
	var tween := create_tween()
	tween.tween_property(_lilith, "global_position:x", LILITH_EXIT_X, distance / LILITH_RUN_SPEED)
	await tween.finished
	_lilith.visible = false


func _on_flag(flag: StringName, _value: Variant) -> void:
	if flag == &"escucho_conversacion" and not _escena_iniciada:
		_escena_iniciada = true
		_escena_monja()


func _escena_monja() -> void:
	await EventBus.dialogue_finished          # termina la conversacion tras la puerta
	GameState.lock_input(&"escena_monja")
	await get_tree().create_timer(0.6).timeout
	# La monja entra desde la derecha del escenario y se para junto a Malaes
	var player := get_tree().get_first_node_in_group(&"player") as Node3D
	var stand := Vector3(minf(player.global_position.x + NUN_OFFSET, NUN_END_X - 1.0), 0.0, 0.0)
	await _monja.appear(Vector3(NUN_ENTRY_X, 0.0, 0.0), stand)
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("monja_descubre"))
	await EventBus.dialogue_finished
	GameState.unlock_input(&"escena_monja")
	_castigo.start()


## Cada golpe derrama mas sangre justo bajo los pies de Malaes; el charco se queda ahi.
func _on_castigo_golpe(_count: int, _total: int) -> void:
	var player := get_tree().get_first_node_in_group(&"player") as Node3D
	if player:
		_sangre.spill(player.global_position)


func _on_castigo_completado() -> void:
	# El minijuego libera el input al terminar: se vuelve a bloquear hasta que la monja hable
	GameState.lock_input(&"escena_monja")
	await get_tree().create_timer(0.8).timeout
	EventBus.dialogue_requested.emit(DialogueDB.load_lines("monja_guia"))
	await EventBus.dialogue_finished
	GameState.unlock_input(&"escena_monja")
	EventBus.objective_changed.emit("Sigue a la monja  →")
	_monja.look_toward(1.0)
	await _monja.lead_to(NUN_END_X)
	# La monja ya salio de escena: el letrero sigue hasta tocar la pared derecha
