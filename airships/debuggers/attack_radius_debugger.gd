extends Node2D

@export var radius_object: Node2D


func _process(delta):
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, radius_object.range, Color.RED, false, 16)
