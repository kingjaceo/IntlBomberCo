class_name EscapeMenu
extends GameMenu


func _resume():
	Engine.time_scale = 1
	visible = false


func _input(event):
	if event.is_action_pressed("escape"):
		_toggle()
