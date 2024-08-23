class_name ItemIcon
extends TextureRect

@export var item: GameItem
@onready var label = $Label

func _ready():
	if item:
		label.text = str(item.amount)
		item.amount_changed.connect(_amount_changed)


func _amount_changed():
	label.text = str(item.amount)
