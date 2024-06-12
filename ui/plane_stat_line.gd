class_name PlaneStatLine
extends HBoxContainer

var game_data: GameData
var plane_stat: GameStat
@onready var name_label = %Name
@onready var value = %Amount
@onready var buy = %Buy
@onready var cost_label = %Cost


func _ready():
	game_data = Global.game_data
	name_label.text = plane_stat.name
	_update()
	buy.text = "+" + str(plane_stat.step_size)
	cost_label.text = Utility.format_money(plane_stat.step_cost)
	plane_stat.value_changed.connect(_update)
	buy.pressed.connect(_increment)


func _increment():
	if plane_stat.value < plane_stat.max_value and game_data.money >= plane_stat.step_cost:
		game_data.money -= plane_stat.step_cost
		plane_stat.value += plane_stat.step_size


func _update():
	value.text = "(" + str(plane_stat.value) + "/" + str(plane_stat.max_value) + ")"
