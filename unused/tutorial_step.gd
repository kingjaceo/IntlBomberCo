class_name TutorialStep
extends Control

@export var step_name: String
@export var step_number: int
signal step_finished


func _ready():
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	z_index = 10
	Tutorial.step_finished.connect(_on_other_step_finished)
	if Global.game_data.tutorial_active and Tutorial.current_step == step_number:
		_transition()


func _on_trigger():
	if Tutorial.current_step == step_number:
		Tutorial.step_finished.emit(step_number)
		hide()


func _on_other_step_finished(other_step_number: int):
	if step_number - other_step_number == 1:
		_transition()


func _transition():
	await get_tree().create_timer(0.25).timeout
	show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.BLUE, 0.1)
	await tween.finished
	#await get_tree().create_timer(0.1).timeout
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	await tween.finished
