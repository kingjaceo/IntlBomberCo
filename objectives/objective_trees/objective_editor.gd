class_name ObjectiveEditor
extends Control

@onready var objective_name: TextEdit = %ObjectiveName
@onready var description: TextEdit = %Description
@onready var flavor_text: TextEdit = %FlavorText
@export var objective: Objective:
	set(value):
		objective = value
		_populate_fields()


func _ready():
	if objective:
		_populate_fields()


func _populate_fields():
	if objective_name:
		objective_name.text = objective.name
	if description:
		description.text = objective.description
	if flavor_text:
		flavor_text.text = objective.flavor_text


func _save():
	print("I'd like to save this objective to disk!")


func _on_objective_name_text_changed() -> void:
	objective.name = objective_name.text


func _on_description_text_changed() -> void:
	objective.description = description.text


func _on_flavor_text_text_changed() -> void:
	objective.flavor_text = flavor_text.text
