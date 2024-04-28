extends Node3D

signal on_line(line_number)

@export var camera_speed = 2.0
@export var line_height_meters = 5.0
@export var damping = 0.1

var velocity = Vector3.ZERO
var target_velocity = Vector3.ZERO
var tween
var isTweened = true
var isMovedForward = true
var isMovedDown = true
var isMovedRight = true
var isMovedLeft = true

func move_forward():
	tween = create_tween().set_trans(Tween.TRANS_EXPO)
	isTweened = false
	tween.tween_property(self, "position", Vector3(position.x, position.y, (position.z - line_height_meters)), 0.5)
	tween.tween_callback(set_is_tween.bind(true))

func move_down():
	tween = create_tween().set_trans(Tween.TRANS_EXPO)
	isTweened = false
	tween.tween_property(self, "position", Vector3(position.x, position.y, (position.z + line_height_meters)), 0.5)
	tween.tween_callback(set_is_tween.bind(true))

func set_is_tween(isTweend: bool):
	isTweened = isTweend

func _process(delta):
	if Input.is_action_pressed("right") and isMovedRight:
		target_velocity.x = line_height_meters
	elif Input.is_action_pressed("left") and isMovedLeft:
		target_velocity.x = -line_height_meters
	else:
		target_velocity.x = 0

	velocity.x = lerp(velocity.x, target_velocity.x, damping)
	position.x += velocity.x * camera_speed * delta

	if Input.is_action_just_pressed("forward") and isTweened and isMovedForward:
		move_forward()
	if Input.is_action_just_released("down") and isTweened and isMovedDown:
		move_down()

func _on_line_3_area_entered(area):
	if area.is_in_group("player_camera"):
		isMovedForward = false
		on_line.emit(3)
		#print("Line 3")

func _on_line_2_area_entered(area):
	if area.is_in_group("player_camera"):
		isMovedForward = true
		isMovedDown = true
		on_line.emit(2)
	#print("Line 2")

func _on_line_area_entered(area):
	if area.is_in_group("player_camera"):
		isMovedForward = true
		isMovedDown = false
		on_line.emit(1)
	#print("Line 1")

func _on_line_y_right_area_entered(area):
	if area.is_in_group("player_camera"):
		isMovedRight = false
		print("Right void")

func _on_line_y_right_area_exited(area):
	if area.is_in_group("player_camera"):
		isMovedRight = true

func _on_line_y_left_area_entered(area):
	if area.is_in_group("player_camera"):
		isMovedLeft = false
		print("Left void")

func _on_line_y_left_area_exited(area):
	if area.is_in_group("player_camera"):
		isMovedLeft = true
