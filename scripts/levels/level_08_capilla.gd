extends LevelBase
## Escenario 6: capilla. La nota en el centro dice "Larga vida a Samael, larga vida a MALAES".
## TODO: primer plano de Malaes llorando y oscurecer la pantalla.

@onready var _nota: Interactable = $Nota


func _on_level_ready() -> void:
	var nota := find_env_node("Nota")
	if nota:
		_nota.global_position = nota.global_position + Vector3(0, 0.4, 0)
	EventBus.flag_changed.connect(_on_flag)


func _on_flag(flag: StringName, _value: Variant) -> void:
	if flag == &"nota_leida":
		_cerrar()


func _cerrar() -> void:
	await EventBus.dialogue_finished
	SceneManager.change_level(&"09_camino_final")
