extends UnitState

class_name Archer

@onready var animation_player = %AnimatedSprite
@onready var attack_range_col = $AttackRange/CollisionShape3D
@onready var range_attack = $AttackRange
@onready var attack_cooldown = $TimerOnAttackSpeed

@export var unit_health: int
@export var unit_movement_speed: float
@export var unit_attack_range: int
@export var unit_attack_speed: float
@export var unit_attack_damage: int

var currnet_enemi_attack: Array = []

func _ready():
	health = unit_health
	movement_speed = unit_movement_speed
	animation_sprite = animation_player
	attack_range = unit_attack_range
	attack_speed = unit_attack_speed
	attack_damage = unit_attack_damage
	attack_range_col.shape.size.x = unit_attack_range
	attack_cooldown.wait_time = unit_attack_speed

func _on_tree_entered():
	current_state = "move"
	print("Spawn: Archer")
#
func _on_attack_range_body_entered(body):
	if body.is_in_group("goblin"):
		current_state = "attack"
		currnet_enemi_attack.push_back(body)
		attack_cooldown.start()

func _on_timer_on_attack_speed_timeout():
	var unit_current_attack
	if currnet_enemi_attack.size() > 0:
		unit_current_attack = currnet_enemi_attack.back()
		if unit_current_attack == null:
			currnet_enemi_attack.pop_back()
		if unit_current_attack != null:
			unit_current_attack.take_damage(attack_damage)
	else:
		attack_cooldown.stop()
		current_state = "move"

func _on_die():
	attack_cooldown.stop()
	self.queue_free()

#func _on_attack_range_area_exited(area):
	#attack_cooldown.stop()
	#current_state = "move"

#func _on_attack_range_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#if body.is_in_group("goblin"):
		#current_state = "attack"
		#currnet_enemi_attack = body
		#attack_cooldown.start()
