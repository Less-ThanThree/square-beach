extends Node3D

#@export var isForwardMove = true
#@export var isDownMove = true
#
#@onready var area = $Line

#func _ready():
	#area.body_entered.connect(_on_area)
#
#func _on_area(body):
	#print(body)
#func _on_area_3d_area_entered(area):
	#if (area.get_name() == 'Player'):
		#print("isPlayer")
