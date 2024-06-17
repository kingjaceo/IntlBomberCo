class_name FuelBurner
extends Node

@onready var timer = %Timer
@onready var label = %Label


func start():
	var parent_plane = get_parent().current_plane
	timer.start(parent_plane.range_s.value)


func _process(delta):
	label.text = str(round(timer.time_left))
