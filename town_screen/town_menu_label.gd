extends Label


func _ready():
	if Global.current_settlement_data:
		text = Global.PlaceName.keys()[Global.current_settlement_data.settlement_name]
