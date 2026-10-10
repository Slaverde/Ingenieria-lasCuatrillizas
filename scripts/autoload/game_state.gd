extends Node
## Estado global de la partida: flags de historia, bloqueo de input, nivel actual.
## NO hay inventario (segun el guion): la carta en latin es solo un flag.

var flags: Dictionary = {}
var current_level_id: StringName = &""
var _locks: Dictionary = {}   # motivo -> true


# --- Bloqueo de input (dialogos, transiciones, minijuegos) ---
func lock_input(reason: StringName) -> void:
	_locks[reason] = true

func unlock_input(reason: StringName) -> void:
	_locks.erase(reason)

func is_input_locked() -> bool:
	return not _locks.is_empty()


# --- Flags de historia ---
func set_flag(flag: StringName, value: Variant = true) -> void:
	flags[flag] = value
	EventBus.flag_changed.emit(flag, value)

func get_flag(flag: StringName, default: Variant = false) -> Variant:
	return flags.get(flag, default)

func reset() -> void:
	flags.clear()
	_locks.clear()
