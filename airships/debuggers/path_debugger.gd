extends Node2D

var target: Node2D


func _process(delta):
	if is_instance_valid(owner.target):
		target = owner.target
	else:
		target = null
	queue_redraw()


func _draw():
	if target:
		# pixels/s / degs/s = pixels/degs
		var forward_change = target.position_change.length()
		var rotation_change = deg_to_rad(target.rotation_change)
		var radius = forward_change / rotation_change
		var center = Vector2(0, radius)
		draw_arc(center, radius, 0, -PI/2, 100, Color.BLUE, 16)
