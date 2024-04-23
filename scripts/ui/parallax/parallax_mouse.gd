extends Control

var relative_y
var relative_x
var mouse_pos

@onready var parallax_far = $Control/ParallaxLayerFar
@onready var parallax_middle = $Control/ParallaxLayerMiddle
@onready var parallax_close = $Control/ParallaxLayerClose

func _process(delta):
	mouse_pos = get_global_mouse_position()
	parallax_far.motion_offset.x = mouse_pos.x / 1000
	parallax_middle.motion_offset.x = mouse_pos.x / 100
	parallax_close.motion_offset.x = mouse_pos.x / 10
