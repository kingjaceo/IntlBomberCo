class_name SiteBoundary
extends Area2D

var radius: float

func _ready():
	radius = get_child(0).shape.radius
	pass
