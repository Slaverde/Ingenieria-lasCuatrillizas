class_name DialogueDB
extends RefCounted
## Carga dialogos desde res://data/dialogues/<id>.json
## Formato: [ {"speaker": "Malaes", "text": "...", "portrait": "res://assets/ui/portraits/x.png"}, ... ]
## "speaker" y "portrait" son opcionales (sin speaker = pensamiento / narracion).
## "style": "letter" muestra la linea como una carta: centrada, grande y a pantalla completa.
## "auto": N avanza la linea sola a los N segundos; "free_walk": true en la primera linea deja caminar al jugador mientras habla.
## En cartas largas se pueden dar "font_size" (por defecto 52) y "width" (ancho en px, por defecto 760).

static func load_lines(id: String) -> Array:
	var path := "res://data/dialogues/%s.json" % id
	if not FileAccess.file_exists(path):
		push_error("DialogueDB: no existe %s" % path)
		return []
	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	if parsed is Array:
		return parsed
	push_error("DialogueDB: JSON invalido en %s" % path)
	return []
