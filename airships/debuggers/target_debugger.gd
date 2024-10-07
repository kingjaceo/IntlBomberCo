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
		draw_line(Vector2.ZERO, owner.to_local(target.position), Color.RED, 16)
