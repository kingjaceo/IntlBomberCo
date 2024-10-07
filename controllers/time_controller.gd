class_name TimeController
extends Node


func _input(event):
	if Input.is_action_just_pressed("pause") and Engine.time_scale != 0:
		Engine.time_scale = 0
	elif Input.is_action_just_pressed("pause"):
		Engine.time_scale = 1
