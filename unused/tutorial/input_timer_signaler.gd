extends Node

@export var required_key_press_time: float = 0.25
var up_time_pressed: float
var down_time_pressed: float
var action_count: int = 0

signal up_time_finished
signal down_time_finished
signal action_pressed
signal item_dropped

func _process(delta):
	if Tutorial.current_step == 0 and Input.is_action_pressed("down"):
		down_time_pressed += delta
		if down_time_pressed >= 1:
			down_time_finished.emit()
	elif Tutorial.current_step == 1 and Input.is_action_pressed("up"):
		up_time_pressed += delta
		if up_time_pressed >= 1:
			up_time_finished.emit()
	elif Tutorial.current_step == 2 and Input.is_action_just_pressed("action"):
		action_pressed.emit()
	elif Tutorial.current_step == 3 and Input.is_action_just_pressed("action"):
		item_dropped.emit()
