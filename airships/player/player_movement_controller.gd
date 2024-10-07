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
	if not Global.input_disabled:
		if Input.is_action_just_pressed("up"):
			player.power_levels["wind"] = min(player.power_levels["wind"] + 1, player.max_power_level)
		if Input.is_action_just_pressed("down"):
			player.power_levels["wind"] = max(player.power_levels["wind"] - 1, 0)
		player.power_levels["lightning"] = player.max_power_level - player.power_levels["wind"]
		_check_update_rotation(delta)
	_move(delta)


func _move(delta):
	var actual_speed = player.forward_speed * player.actual_power_levels['wind']
	var position_change = player.transform.x * actual_speed * delta
	player.position += position_change


func _check_update_rotation(delta: float):
	var actual_rotation_speed = player.rotation_speed * player.actual_power_levels['wind']
	var rotation_change = delta * actual_rotation_speed
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
