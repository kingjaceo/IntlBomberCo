class_name TutorialLayer
extends CanvasLayer

@export var steps: Array[Control]
var current_step: Control
var current_step_index: int = 0

#func _ready():
	#visible = Global.game_data.tutorial_active
	#Global.game_data.tutorial_toggled.connect(_toggle)
#
#
#
#func _toggle():
	#visible = not visible
#
#
#func _next_step():
	#current_step.hide()
	#current_step_index += 1
	#current_step = steps[current_step_index]
	#current_step.show()
