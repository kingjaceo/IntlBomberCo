class_name PlayerMovementController
extends Node

var player: Player
var current_airship: AirshipData
var rotation_speed: float
var forward_speed: float


func _ready():
	player = owner
	current_airship = player.current_airship
	rotation_speed = current_airship.rotation_speed.value
	forward_speed = current_airship.forward_speed.value


func _process(delta):
	if Input.is_action_just_pressed("up"):
		forward_speed += current_airship.forward_speed.step_size
		forward_speed = min(forward_speed, current_airship.forward_speed.max_value)
	if Input.is_action_just_pressed("down"):
		forward_speed -= current_airship.forward_speed.step_size
		forward_speed = max(forward_speed, 0)
	player.position += player.transform.x * forward_speed * delta
	check_update_rotation(delta)


func check_update_rotation(delta: float):
	var rotation_change = rotation_speed * delta
	if Input.is_action_pressed("left"):
		player.rotation_degrees -= rotation_change
	if Input.is_action_pressed("right"):
		player.rotation_degrees += rotation_change


func _minimum_speed():
	forward_speed = current_airship.forward_speed.step_size


func _cruising_speed():
	forward_speed = current_airship.forward_speed.step_size * 2


func _stop():
	forward_speed = 0


func _on_site_detector_area_entered(area):
	pass # Replace with function body.
