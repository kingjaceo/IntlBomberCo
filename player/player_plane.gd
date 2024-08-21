class_name PlayerPlane
extends Node2D

var game_data: GameData
@export var current_airship: AirshipData
var rotation_speed: float
var forward_speed: float
var placed: bool = false
@onready var camera = %Camera2D
var width: float
var overworld_position: Vector2
var overworld_radius: float
var angle: float
var zoom_factor: float = 8

signal started
signal item_dropped
signal returned_home


func _ready():
	if current_airship:
		Global.player_airship_data = current_airship
	elif Global.player_airship_data:
		current_airship = Global.player_airship_data
	else:
		push_error("No AirshipData detected for player!")
	camera.zoom = camera.zoom * 0.25
	scale = scale * 4
	width = get_node("SiteDetector/CollisionShape2D").shape.size.x
	game_data = Global.game_data
	rotation_speed = current_airship.rotation_speed.value
	forward_speed = current_airship.forward_speed.value


func _process(delta):
	if Input.is_action_just_pressed("up"):
		forward_speed += current_airship.forward_speed.step_size
		forward_speed = min(forward_speed, current_airship.forward_speed.max_value)
	if Input.is_action_just_pressed("down"):
		forward_speed -= current_airship.forward_speed.step_size
		forward_speed = max(forward_speed, 0)
	position += transform.x * forward_speed * delta
	check_update_rotation(delta)


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
		rotation_degrees -= rotation_change
	if Input.is_action_pressed("right"):
		rotation_degrees += rotation_change


func check_update_position():
	if Input.is_action_pressed("up"):
		position.y -= 5
	if Input.is_action_pressed("down"):
		position.y += 5


func _input(event):
	#if not placed and event.is_action_pressed("action"): # event.is_action("confirm"):
		#placed = true
		#started.emit()
	if event.is_action_pressed("action"): # event.is_action_("confirm"):
		drop_active_item()


func _on_site_entered(area: Area2D):
	# scoot plane forward to account for zoom change
	position += transform.x * width
	# change zoom of camera
	camera.zoom *= zoom_factor
	scale *= 1 / zoom_factor
	var settlement = area.owner
	Global.current_settlement_data = settlement.data


func _on_site_exited(area: Area2D):
	camera.zoom *= 1 / zoom_factor
	scale *= zoom_factor
	position += transform.x * width
