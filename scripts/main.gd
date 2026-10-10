extends Node
## Punto de entrada. TODO: menu principal. Por ahora arranca directo en el primer nivel.

func _ready() -> void:
	GameState.reset()
	SceneManager.change_level.call_deferred(LevelRegistry.FIRST)
