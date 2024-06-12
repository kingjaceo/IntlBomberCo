extends Node


var current_step: int

signal step_finished(step_number: int)


func _ready():
	step_finished.connect(_on_step_finished)


func _on_step_finished(last_step: int):
	current_step += 1
