class_name Dock
extends Area2D

var dock_point: Vector2
@export_range(0, 360) var dock_orientation: float


func _ready():
	dock_point = get_node("Dockpoint").global_position
	dock_orientation = deg_to_rad(dock_orientation)
