class_name ShopColumn
extends VBoxContainer

@export var column_name: String
var game_data: GameData
@onready var column_name_label = %ColumnName


func _ready():
	game_data = Global.game_data
	column_name_label.text = column_name
