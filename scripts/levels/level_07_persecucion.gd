extends LevelBase
## Escenario 5 (parte 2): persecucion con camara a la espalda.
## Shift corre, Espacio salta, A/D cambia de carril. Cerca del final: "E para esconderte".
## Si Lilith te alcanza o fallas el QTE -> mueres y reinicia el nivel.
## TODO: animacion de Lilith despedazando a Malaes; reiniciar desde la transformacion.

const DIALOGOS: Array[String] = [
	"POR QUÉ",
	"ES A TI A QUIEN QUIEREN, NO A MÍ… NO A MÍ",
	"ES TU CULPA QUE AHORA SEA ASÍ",
	"TÚ ERES A QUIEN BUSCAN",
	"YO SOLO FUI UNA PRUEBA",
]

@export var chaser_delay := 3.0

@onready var _chaser: LilithChaser = $LilithChaser
@onready var _qte: HideQTE = $HideQTE
@onready var _qte_zone: Area3D = $QteZone

var _qte_started := false


func _on_level_ready() -> void:
	var player := get_tree().get_first_node_in_group(&"player") as Player
	player.can_run = true
	player.can_jump = true
	_qte_zone.body_entered.connect(_on_qte_zone)
	_qte.succeeded.connect(func() -> void: _chaser.active = false)
	EventBus.prompt_changed.emit("Oprime SHIFT para correr")
	await get_tree().create_timer(chaser_delay).timeout
	EventBus.prompt_changed.emit("")
	_chaser.active = true
	_hablar()


func _on_qte_zone(body: Node3D) -> void:
	if body is Player and not _qte_started:
		_qte_started = true
		_qte.start()


func _hablar() -> void:
	var i := 0
	while is_inside_tree() and _chaser.active:
		EventBus.prompt_changed.emit(DIALOGOS[i % DIALOGOS.size()])
		i += 1
		await get_tree().create_timer(2.0).timeout
		EventBus.prompt_changed.emit("")
		await get_tree().create_timer(3.0).timeout
