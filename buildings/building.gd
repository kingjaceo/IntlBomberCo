extends Node2D

@onready var sprite_2d: Sprite2D = %Sprite2D
var health: float = 100
var width: float = 0
var height: float = 0
@export var building_type: BuildingType
var destroyed: bool

signal building_destroyed


func _ready():
	if building_type.building_type & 8:
		modulate = Color.RED
	elif building_type.building_type & 4:
		modulate = Color.DARK_GRAY
	elif building_type.building_type & 2:
		modulate = Color.GREEN
	elif building_type.building_type & 1:
		modulate = Color.BLUE
	
	width = sprite_2d.get_rect().size[0]
	height = sprite_2d.get_rect().size[1]


func damage(amount: float):
	health -= amount
	if not destroyed and health <= 0:
		destroyed = true
		sprite_2d.set_modulate(Color.BLACK)
		building_destroyed.emit()
		Events.building_destroyed.emit(building_type.building_type)
