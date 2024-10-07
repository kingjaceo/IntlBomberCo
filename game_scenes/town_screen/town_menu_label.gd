class_name TownMenuLabel
extends Label


func _ready():
	if Global.current_settlement_data:
		text = Enums.PlaceName.keys()[Global.current_settlement_data.settlement_name]
