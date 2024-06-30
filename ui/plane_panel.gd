class_name PlanePanel
extends Control

var game_data: GameData
var plane: Airplane
@onready var name_label: Label = %Name
@onready var plane_stat_container: VBoxContainer = %PlaneStatContainer
@onready var stat_panel: StatPanel = %StatPanel


func _ready():
	game_data = Global.game_data
	name_label.text = str(plane.name)
	#_make_lines()


func _make_lines():
	for game_stat in plane.get_stats():
		var line = stat_panel.duplicate(DUPLICATE_GROUPS)
		line.visible = true
		line.game_stat = game_stat
		add_child(line)
