extends Node
## Bus global de senales. Los sistemas se comunican por aqui para no acoplarse.

signal level_started(level_id: StringName)
signal dialogue_requested(lines: Array)
signal dialogue_finished
signal prompt_changed(text: String)               # "" = ocultar
signal camera_mode_requested(mode: StringName)    # &"side" | &"behind"
signal flag_changed(flag: StringName, value: Variant)
signal player_died
