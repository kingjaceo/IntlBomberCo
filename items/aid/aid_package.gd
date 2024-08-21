class_name AidPackage
extends Node2D

@onready var sprite_2d = $Sprite2D


func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale", Vector2(0.1, 0.1), 2)
	await tween.finished
