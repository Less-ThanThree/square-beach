extends UnitState

@onready var animation_player = %AnimatedSprite
@onready var attack_range_col = $AttackRange/CollisionShape3D
@onready var range_attack = $AttackRange
@onready var attack_cooldown = $TimerOnAttackSpeed
@onready var on_enemie_check = $TimerOnCheckEnemie

@export var unit_health: int
@export var unit_movement_speed: float
@export var unit_attack_range: int
@export var unit_attack_speed: float
@export var unit_attack_damage: int
@export var unit_is_enemy: bool = false

var currnet_enemi_attack: Array = []
var current_group
var current_line

func _ready():
	if unit_is_enemy:
		add_to_group("goblin")
		current_group = "allience"
		animation_player.flip_h = true
	else:
		add_to_group("allience")
		current_group = "goblin"
	
	health = unit_health
	movement_speed = unit_movement_speed
	animation_sprite = animation_player
	attack_range = unit_attack_range
	attack_speed = unit_attack_speed
	attack_damage = unit_attack_damage
	is_enemy = unit_is_enemy
	attack_range_col.shape.size.x = unit_attack_range
	attack_cooldown.wait_time = unit_attack_speed

func _on_tree_entered():
	current_state = "move"
	print("Spawn: SageBark")
#
func _on_attack_range_body_entered(body):
	if body.is_in_group(current_group) && body.current_line == current_line:
		current_state = "attack"
		currnet_enemi_attack.push_back(body)
		attack_cooldown.start()

func _on_timer_on_attack_speed_timeout():
	var unit_current_attack
	on_enemie_check.start()
	if currnet_enemi_attack.size() > 0:
		unit_current_attack = currnet_enemi_attack.back()
		if unit_current_attack == null:
			currnet_enemi_attack.pop_back()
		if unit_current_attack != null:
			unit_current_attack.take_damage(attack_damage)
	else:
		on_enemie_check.stop()
		attack_cooldown.stop()
		current_state = "move"

func _on_die():
	current_state = "die"
	on_enemie_check.stop()
	attack_cooldown.stop()
	await animation_player.animation_finished
	self.queue_free()

func _on_hit():
	current_state = "hit"
	await animation_player.animation_finished
	if currnet_enemi_attack.size() > 0:
		current_state = "attack"
	else:
		current_state = "move"

func _on_timer_on_check_enemie_timeout():
	if currnet_enemi_attack.size() == 0:
		current_state = "move"
		attack_cooldown.stop()
