extends Node
## Registra las acciones de input por codigo (asi no dependemos del editor).
## Acciones: move_left, move_right, move_forward, move_back, interact, sprint, jump

func _ready() -> void:
	_bind(&"move_left", [KEY_A, KEY_LEFT])
	_bind(&"move_right", [KEY_D, KEY_RIGHT])
	_bind(&"move_forward", [KEY_W, KEY_UP])
	_bind(&"move_back", [KEY_S, KEY_DOWN])
	_bind(&"interact", [KEY_E])
	_bind(&"sprint", [KEY_SHIFT])
	_bind(&"jump", [KEY_SPACE])


func _bind(action: StringName, keys: Array) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	for key in keys:
		var ev := InputEventKey.new()
		ev.physical_keycode = key
		InputMap.action_add_event(action, ev)
