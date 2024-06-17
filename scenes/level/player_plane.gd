class_name PlayerPlane
extends Node2D

var game_data: GameData
var current_plane: Airplane
var rotation_speed: float
var forward_speed: float
var placed: bool = false
@onready var fuel_burner: FuelBurner = %FuelBurner

signal started
signal item_dropped
signal returned_home


func _ready():
	game_data = Global.game_data
	current_plane = game_data.current_plane
	rotation_speed = current_plane.rotation_speed.value
	forward_speed = current_plane.forward_speed.value


func _process(delta):
	if placed:
		position += transform.x * forward_speed * delta
		check_update_rotation(delta)
	else:
		check_update_position()


func drop_active_item():
	if game_data.active_item and game_data.active_item.amount > 0:
		game_data.active_item.amount -= 1
		item_dropped.emit()
		var new_item = game_data.active_item.instantiate()
		new_item.item = game_data.active_item
		get_parent().add_child(new_item)
		new_item.position = position


func check_update_rotation(delta: float):
	var rotation_change = rotation_speed * delta
	if Input.is_action_pressed("left"):
		rotation -= rotation_change
	if Input.is_action_pressed("right"):
		rotation += rotation_change


func check_update_position():
	if Input.is_action_pressed("up"):
		position.y -= 5
	if Input.is_action_pressed("down"):
		position.y += 5


func _input(event):
	if not placed and event.is_action_pressed("action"): # event.is_action("confirm"):
		placed = true
		fuel_burner.start()
		started.emit()
	elif event.is_action_pressed("action"): # event.is_action_("confirm"):
		drop_active_item()

