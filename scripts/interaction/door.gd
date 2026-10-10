class_name Door
extends Interactable
## Puerta que se abre con [E] y lleva a otro nivel.

@export var target_level: StringName
@export var target_spawn: StringName = &"Default"
@export var required_flag: StringName = &""     # vacio = siempre abierta
@export var locked_dialogue_id := ""            # que se dice si esta bloqueada


func _on_interact(_player: Node3D) -> void:
	if required_flag != &"" and not GameState.get_flag(required_flag):
		if locked_dialogue_id != "":
			EventBus.dialogue_requested.emit(DialogueDB.load_lines(locked_dialogue_id))
		return
	SceneManager.change_level(target_level, target_spawn)
