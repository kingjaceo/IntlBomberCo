class_name Airplane
extends Node2D

@export var speed: float = 10
@export var forward_speed: float = 100
var game_data: GameData
@export var max_x: float = 2000
@export var max_y: float = 1000

var target_position: Vector2

var placed: bool = false

signal item_dropped


func _ready():
	game_data = Global.game_data
	target_position = position


func _process(delta):
	if placed:
		target_position.x += forward_speed * delta
	clampf(position.x, 0, max_x)
	clampf(position.y, 0, max_y)
	position = lerp(position, target_position, 0.9)


func drop_active_item():
	if game_data.active_item and game_data.active_item.amount > 0:
		game_data.active_item.amount -= 1
		item_dropped.emit()
		var new_item = game_data.active_item.instantiate()
		new_item.item = game_data.active_item
		get_parent().add_child(new_item)
		new_item.position = position


func _unhandled_input(event):
	if not placed and event.is_action_pressed("action"): # event.is_action("confirm"):
		placed = true
	elif event.is_action("up"):
		target_position.y -= speed
	elif event.is_action("down"):
		target_position.y += speed
	elif event.is_action_pressed("action"): # event.is_action_("confirm"):
		drop_active_item()
	
