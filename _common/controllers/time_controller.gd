class_name TimeController
extends Node


func _input(event):
	if Input.is_action_just_pressed("1"):
		Engine.time_scale = 1
		get_tree().paused = false
	elif Input.is_action_just_pressed("2"):
		Engine.time_scale = 2
		get_tree().paused = false
	elif Input.is_action_just_pressed("3"):
		Engine.time_scale = 5
		get_tree().paused = false
	
	if Input.is_action_just_pressed("pause") and get_tree().paused:
		get_tree().paused = false
	elif Input.is_action_just_pressed("pause"):
		get_tree().paused = true
