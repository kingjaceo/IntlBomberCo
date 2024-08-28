extends Control

@onready var objective_name: TextEdit = %ObjectiveName
@export var objective: Objective:
	set(value):
		objective = value
		_populate_fields()


func _ready():
	if objective:
		_populate_fields()


func _populate_fields():
	objective_name.text = objective.name


func _save():
	print("I'd like to save this objective to disk!")
