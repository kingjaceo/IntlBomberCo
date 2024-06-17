class_name FoodPackage
extends Node2D

@onready var sprite_2d = %Sprite2D
var item: AidItem

func _ready():
	var tween = get_tree().create_tween()
	Events.aid_delivered.emit(position)
	tween.tween_property(sprite_2d, "scale", Vector2(0.1, 0.1), 2)
	await tween.finished
