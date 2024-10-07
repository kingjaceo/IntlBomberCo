extends CanvasItem

var mouse_here: bool = false


func _input(event):
	if event.is_action_pressed("select") and mouse_here:
		Global.player_target = owner
		modulate = Color.WHITE
		visible = true
	elif event.is_action_pressed("select"):
		visible = false


func _on_mouse_entered() -> void:
	mouse_here = true


func _on_mouse_exited() -> void:
	mouse_here = false
