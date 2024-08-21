extends Node


var current_tutorial_steps: Dictionary = {}

signal step_finished(step_number: int)


func _ready():
	current_tutorial_steps["CompanyPage"] = 0
	current_tutorial_steps["Level"] = 0
