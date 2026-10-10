extends LevelBase
## Escenario 5 (parte 1): galeria con escalera. Lilith, en el suelo, se transforma en monstruo
## y comienza la persecucion (nivel 07).
## TODO: modelo y animacion de la transformacion, "Lilith?!" al acercarse, cuadros que se mueven.

func _on_level_ready() -> void:
	# Rampas invisibles sobre la escalera (descansillo y peldanos), en la linea z = -1.15
	add_ramp(Vector2(0.0, 2.5), Vector2(1.4, 2.5), -1.15, 1.7)
	add_ramp(Vector2(1.4, 2.5), Vector2(5.6, 0.03), -1.15, 1.7)
	EventBus.flag_changed.connect(_on_flag)


func _on_flag(flag: StringName, _value: Variant) -> void:
	if flag == &"encuentro_lilith_terminado":
		_transformacion()


func _transformacion() -> void:
	await EventBus.dialogue_finished
	EventBus.prompt_changed.emit("LILITH TE PERSIGUE ¡HUYE!")   # TODO: letrero rojo ensangrentado
	await get_tree().create_timer(2.0).timeout
	EventBus.prompt_changed.emit("")
	SceneManager.change_level(&"07_persecucion")
