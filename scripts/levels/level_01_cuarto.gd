extends LevelBase
## Escenario 1: Malaes despierta, tras unos segundos pasan la carta bajo la puerta.
## TODO: animacion de levantarse de la cama, sfx de toques en la puerta.

@export var seconds_before_letter := 5.0

@onready var _letter: Interactable = $Letter


func _on_level_ready() -> void:
	await get_tree().create_timer(seconds_before_letter).timeout
	_letter.visible = true
	_letter.enabled = true
