class_name Interactable
extends Area3D
## Cualquier cosa con la que el jugador interactua con [E].
## Se le agrega un CollisionShape3D hijo. Layer 2 = interactuables.

signal interacted(player: Node3D)

@export var prompt_text := "Interactuar"
@export var enabled := true
@export var one_shot := false
@export var dialogue_id := ""                       # opcional: lanza data/dialogues/<id>.json
@export var set_flag_on_interact: StringName = &""  # opcional: activa un flag de historia

var _used := false


func _ready() -> void:
	collision_layer = 2
	collision_mask = 0
	monitoring = false


func can_interact() -> bool:
	return enabled and not (one_shot and _used)


func interact(player: Node3D) -> void:
	if not can_interact():
		return
	if one_shot:
		_used = true
	if set_flag_on_interact != &"":
		GameState.set_flag(set_flag_on_interact)
	interacted.emit(player)
	if dialogue_id != "":
		EventBus.dialogue_requested.emit(DialogueDB.load_lines(dialogue_id))
	_on_interact(player)


## Para subclases (Door, altar, etc.)
func _on_interact(_player: Node3D) -> void:
	pass
