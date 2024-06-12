class_name PlaneContainer
extends Control

var game_data: GameData
var plane: Airplane
@onready var name_label = %Name
@onready var plane_stat_container = %PlaneStatContainer
@export var plane_stat_line: PackedScene


func _ready():
	game_data = Global.game_data
	name_label.text = str(plane.name)
	_make_lines()


func _make_lines():
	var forward_speed = plane_stat_line.instantiate()
	forward_speed.plane_stat = plane.forward_speed
	plane_stat_container.add_child(forward_speed)
	
	var rotation_speed = plane_stat_line.instantiate()
	rotation_speed.plane_stat = plane.rotation_speed
	plane_stat_container.add_child(rotation_speed)
	

