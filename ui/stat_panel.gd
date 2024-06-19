class_name StatPanel
extends PanelContainer

var game_data: GameData
@export var game_stat: GameStat
@onready var name_label = %Name
@onready var progress_bar = %ProgressBar
@onready var buy_button = %Buy
@onready var cost_label = %Cost


func _ready():
	game_data = Global.game_data
	game_data.money_changed.connect(_toggle_button)
	name_label.text = str(game_stat.name)
	cost_label.text = Utility.format_money(game_stat.step_cost)
	game_stat.value_changed.connect(_update_amount)
	buy_button.pressed.connect(_increase)
	_set_progress_bar()
	_update_amount()
	_toggle_button()


func _set_progress_bar():
	progress_bar.min_value = 0
	progress_bar.step = game_stat.step_size
	progress_bar.max_value = game_stat.max_value


func _update_amount():
	progress_bar.value = game_stat.value


func _increase():
	if game_stat.value < game_stat.max_value and game_data.money >= game_stat.step_cost:
		game_data.money -= game_stat.step_cost
		game_stat.value += game_stat.step_size


func _toggle_button():
	if game_stat.step_cost > game_data.money:
		buy_button.disabled = true
	else:
		buy_button.disabled = false
