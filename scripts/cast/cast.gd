extends Node

@export var timer_on_type: float = 3
@export var timner_on_cast: float = 30

@onready var cast_word = load("res://scenes/cast/cast_word.tscn")
@onready var book = $CenterContainer/Container/Openbook
@onready var timer_type = $TimerOnType
@onready var timer_cast = $TimerOnCast
@onready var cast_word_1 = $CenterContainer/Container/Openbook/CastWord_1
@onready var cast_word_2 = $CenterContainer/Container/Openbook/CastWord_2
@onready var cast_word_3 = $CenterContainer/Container/Openbook/CastWord_3

var buffer: String
var regex = RegEx.new()
var tween

func _ready():
	timer_type.set_wait_time(timer_on_type)
	generation_words()

func _input(event):
	if event is InputEventKey && event.pressed:
		if event.keycode in range(65, 90):
			buffer += event.as_text_key_label()
			buffer = match_word(buffer.to_lower())
	if event.is_action_pressed("reset"):
		buffer = ""

func generate_word(cast_word, word):
	tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(cast_word.label_settings, 'font_color', Color(0, 0, 0, 0), 1)
	await tween.finished
	tween = create_tween().set_trans(Tween.TRANS_BACK)
	cast_word.text = word
	tween.tween_property(cast_word.label_settings, 'font_color', Color(0, 0, 0, 1), 1)

func generation_words():
	var enemies_word = Global.enemies
	var enemies_keys: Array = []
	var random_seed
	var enemies_scene
	
	for key in enemies_word.keys():
		enemies_keys.push_front(key)

	random_seed = randi_range(0, enemies_keys.size() - 1)	
	cast_word_1.text = enemies_word[enemies_keys[random_seed]].word
	enemies_keys.remove_at(random_seed)
	
	random_seed = randi_range(0, enemies_keys.size() - 1)	
	cast_word_2.text = enemies_word[enemies_keys[random_seed]].word
	enemies_keys.remove_at(random_seed)
	
	random_seed = randi_range(0, enemies_keys.size() - 1)	
	cast_word_3.text = enemies_word[enemies_keys[random_seed]].word
	enemies_keys.remove_at(random_seed)

func match_word(buffer: String):
	if buffer.match(cast_word_1.text):
		generate_word(cast_word_1, "zopa")
		print("Cast: ", cast_word_1.text)
		return ""
	if buffer.match(cast_word_2.text):
		generate_word(cast_word_2, "zopa")
		print("Cast: ", cast_word_2.text)
		buffer = String()
		return ""
	if buffer.match(cast_word_3.text):
		generate_word(cast_word_3, "zopa")
		print("Cast: ", cast_word_3.text)
		return ""
	return buffer
	
