extends Node2D


func _process(delta):
	queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, owner.chase_radius, Color.BLACK, false, 16)
