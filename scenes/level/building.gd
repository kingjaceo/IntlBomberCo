extends Node2D

@onready var sprite_2d: Sprite2D = %Sprite2D
@export var health: float = 100
var width: float = 0
var height: float = 0

signal building_destroyed


func _ready():
	width = sprite_2d.get_rect().size[0]
	height = sprite_2d.get_rect().size[1]


func damage(amount: float):
	health -= amount
	if health <= 0:
		sprite_2d.set_modulate(Color.RED)
		building_destroyed.emit()
