extends Node

@export var timer_on_type: float = 3.0
@export var timner_on_cast: float = 30
@export var min_y_position: float = -60
@export var min_x_position: float = -50
@export var max_y_position: float = 38
@export var max_x_position: float = 38
@export var max_word: int = 4

@onready var cast_word = load("res://scenes/cast/cast_word.tscn")
@onready var cast_blow_particles = load("res://scenes/particles/cast_word_blow.tscn")
@onready var book = $CenterContainer/Container/Openbook
@onready var timer_type = $TimerOnType
@onready var timer_cast = $TimerOnCast 

var buffer: String
var tween: Tween
var availableWord: Array = []
var enemies_keys: Array = []
var is_cast_current_word = false
var current_word_cast
var index: int = 1

func _ready():
	timer_type.set_wait_time(timer_on_type)
	generation_words()

func _input(event):
	if event is InputEventKey && event.pressed:
		if event.keycode in range(65, 90):
			buffer += event.as_text_key_label()
			if is_cast_current_word:
				match_symbols(buffer.to_lower(),index)
				index += 1
			else:
				buffer = buffer[-1]
				index = 1
				match_first_symbols(buffer.to_lower())
			print(buffer)
	if event.is_action_pressed("reset"):
		await match_word(buffer.to_lower())
		if current_word_cast != null:
			if current_word_cast.node.is_inside_tree():
				current_word_cast.node.clear()
				current_word_cast.node.append_text(current_word_cast.word)
		buffer = ""

func generate_single_word():
	var random_seed = randi_range(0, enemies_keys.size() - 1)
	var object_word
	var word_scene
	var particles_scene
	
	# Спавним ноду слова каста
	word_scene = cast_word.instantiate()
	word_scene.text = String(enemies_keys[random_seed])
	word_scene.scale = Vector2(0.3, 0.3)
	word_scene.position = Vector2(randf_range(min_y_position, max_y_position), randf_range(min_x_position, max_x_position))
	
	# Спавним ноду партиклов и ставим позицию в позицию слова
	particles_scene = cast_blow_particles.instantiate()
	particles_scene.position = word_scene.position
	
	# Добавляем ноды слова и партикла в книгу
	book.add_child(word_scene)
	book.add_child(particles_scene)
	
	# Конектим сигнал времени ввода слова
	word_scene.connect("timer_on_type_timeout", _on_word_type_timeout)
	word_scene.set_timer(timer_on_type)
	
	object_word = {
		"word": String(enemies_keys[random_seed]),
		"node": word_scene,
		"particle": particles_scene, 
	}
	availableWord.push_front(object_word)
	enemies_keys.remove_at(random_seed)

func generation_words():
	var enemies_word = Global.enemies
	var random_seed
	var enemies_scene
	var particles_scene
	
	for key in enemies_word.keys():
		enemies_keys.push_front(key)
	
	for i in range(max_word):
		var object_word
		random_seed = randi_range(0, enemies_keys.size() - 1)
		# Спавним ноду слова каста
		enemies_scene = cast_word.instantiate()
		enemies_scene.text = String(enemies_word[enemies_keys[random_seed]].word)
		enemies_scene.scale = Vector2(0.3, 0.3)
		enemies_scene.position = Vector2(randf_range(min_y_position, max_y_position), randf_range(min_x_position, max_x_position))
		
		# Спавним ноду партиклов и ставим позицию в позицию слова
		particles_scene = cast_blow_particles.instantiate()
		particles_scene.position = enemies_scene.position
		
		# Добавляем ноды слова и партикла в книгу
		book.add_child(enemies_scene)
		book.add_child(particles_scene)
		
		# Конектим сигнал времени ввода слова
		enemies_scene.connect("timer_on_type_timeout", _on_word_type_timeout)
		enemies_scene.set_timer(timer_on_type)
		
		object_word = {
			"word": String(enemies_word[enemies_keys[random_seed]].word),
			"node": enemies_scene,
			"particle": particles_scene,
		}
		availableWord.push_front(object_word)
		enemies_keys.remove_at(random_seed)

func match_word(buffer: String):
	for cast in availableWord:
		if buffer.match(cast.word):
			print("Cast: ", cast.word)
			#tween = create_tween().set_trans(Tween.TRANS_BACK)
			#tween.tween_property(current_word_cast.node, 'theme_override_colors/default_color', Color(0.718, 0.573, 0.035), 1)
			#tween.tween_property(cast.node, 'theme_override_colors/default_color', Color(0, 0, 0, 0), 1)
			#await tween.finished
			cast.particle.emitting = true
			add_units(cast.word)
			cast.node.queue_free()
			availableWord.erase(cast)
			enemies_keys.push_front(cast.word)
			generate_single_word()
			is_cast_current_word = false
			index = 1
			return

	if current_word_cast != null:
		#tween = create_tween().set_trans(Tween.TRANS_BACK)
		#tween.tween_property(current_word_cast.node, 'theme_override_colors/default_color', Color(0.718, 0.573, 0.035), 1)
		#await tween.finished
		current_word_cast.particle.emitting = true
		current_word_cast.node.queue_free()
		availableWord.erase(current_word_cast)
		enemies_keys.push_front(current_word_cast.word)
		generate_single_word()
	index = 1
	is_cast_current_word = false

func match_first_symbols(buffer: String):
	for cast in availableWord:
		if buffer[0] == cast.word[0]:
			print("First symnbol in cast: ", cast.word)
			cast.node.clear()
			cast.node.append_text("[shake rate=20.0 level=5 connected=1][color=#b79209]%s[/color][/shake]%s" % [cast.word[0], cast.word.substr(1, cast.word.length())])
			is_cast_current_word = true
			current_word_cast = cast

func match_symbols(buffer: String, index: int):
	var buffer_word = ""
	var i = 0
	
	if current_word_cast != null:
		if buffer.length() > current_word_cast.word.length():
			current_word_cast.node.clear()
			current_word_cast.node.append_text(current_word_cast.word)
			is_cast_current_word = false
			current_word_cast = null
			buffer = String()
			index = 1
			return
		
		while (i <= index):
			buffer_word += buffer[i]
			i += 1

		if buffer[index] == current_word_cast.word[index]:
			if current_word_cast.node.is_inside_tree():
				current_word_cast.node.clear()
				current_word_cast.node.append_text("[shake rate=20.0 level=5 connected=1][color=#b79209]%s[/color][/shake]%s" % [buffer_word, current_word_cast.word.substr(index + 1, current_word_cast.word.length())])
		else:
			if current_word_cast.node.is_inside_tree():
				current_word_cast.node.clear()
				current_word_cast.node.append_text(current_word_cast.word)
			is_cast_current_word = false
			index = 1
			buffer = String()
			current_word_cast = null

func _on_word_type_timeout(word):
	for cast in availableWord:
		if cast.word == word.text:
			cast.particle.emitting = true
			
			if current_word_cast != null:
				if current_word_cast.word == word.text:
					current_word_cast = null
			cast.node.queue_free()
			availableWord.erase(cast)
			enemies_keys.push_front(cast.word)
			generate_single_word()

func add_units(unit_name: String):
	var unit_object = {
		"name": unit_name,
		"count": 0,
	}
	
	for unit in Global.units:
		if unit.name == unit_name:
			unit.count += 1
			return
	
	unit_object.name = unit_name
	unit_object.count = 1
	Global.units.push_front(unit_object)
