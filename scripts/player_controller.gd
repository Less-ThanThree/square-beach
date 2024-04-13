extends Node3D

@export var camera_speed = 1
@export var line_height_meters = 5
var tween
var isTweened = true
var isMovedForward = true
var isMovedDown = true
var isMovedRight = true
var isMovedLeft = true

func move_forward():
	tween = create_tween().set_trans(Tween.TRANS_EXPO)
	isTweened = false
	tween.tween_property(self, "position", Vector3(position.x, position.y, (position.z - line_height_meters)), 1)
	tween.tween_callback(set_is_tween.bind(true))

func move_down():
	tween = create_tween().set_trans(Tween.TRANS_EXPO)
	isTweened = false
	tween.tween_property(self, "position", Vector3(position.x, position.y, (position.z + line_height_meters)), 1)
	tween.tween_callback(set_is_tween.bind(true))

func set_is_tween(isTweend: bool):
	isTweened = isTweend

func _process(delta):
	if Input.is_action_pressed("right") && isMovedRight:
		translate(transform.basis.x * camera_speed * delta)
	if Input.is_action_pressed("left") && isMovedLeft:
		translate(-transform.basis.x * camera_speed * delta)
	if Input.is_action_just_pressed("forward") && isTweened && isMovedForward:
		move_forward()
	if Input.is_action_just_released("down") && isTweened && isMovedDown:
		move_down()

func _on_line_3_area_entered(area):
	isMovedForward = false
	print("Line 3")

func _on_line_2_area_entered(area):
	isMovedForward = true
	isMovedDown = true
	print("Line 2")

func _on_line_area_entered(area):
	isMovedForward = true
	isMovedDown = false
	print("Line 1")

func _on_line_y_right_area_entered(area):
	isMovedRight = false
	print("Right void")

func _on_line_y_right_area_exited(area):
	isMovedRight = true

func _on_line_y_left_area_entered(area):
	isMovedLeft = false
	print("Left void")

func _on_line_y_left_area_exited(area):
	isMovedLeft = true
