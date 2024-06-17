class_name PlanePanel
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
	for game_stat in plane.get_stats():
		var line = plane_stat_line.instantiate()
		line.plane_stat = game_stat
		plane_stat_container.add_child(line)
