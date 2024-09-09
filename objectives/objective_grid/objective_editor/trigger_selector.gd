class_name TriggerSelector
extends OptionButton


func _ready() -> void:
	clear()
	for trigger_type in Enums.TriggerType:
		add_item(trigger_type)
