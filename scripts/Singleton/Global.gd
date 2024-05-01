extends Node

var enemies
var magic
var tron_player_hp: int = 10
var tron_enemie_hp: int = 10
var units: Array = []

func _ready():
	var counter = 0
	enemies = read_from_JSON("res://data/cast_words/cast_words_enemies.json")
	magic = read_from_JSON("res://data/cast_words/cast_words_magic.json")
	for key in enemies.keys():
		enemies[key]["key"] = key
	
	for key in magic.keys():
		magic[key]["key"] = key

func read_from_JSON(path: StringName):
	var file
	var data
	if (FileAccess.file_exists(path)):
		file = FileAccess.open(path, FileAccess.READ)
		data = JSON.parse_string(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Файла не существует ДЕБИЛ!!!")
