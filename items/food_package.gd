class_name FoodPackage
extends Node2D

@onready var sprite_2d = %Sprite2D
@onready var area_2d = %Area2D
@onready var shape = %CollisionShape2D


func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale", Vector2(0.1, 0.1), 2)
	await tween.finished
