class_name ZoomController
extends Node

var target: Camera2D
@export var start_zoom: Vector2 = Vector2(0.75, 0.75)
@export var min_zoom: Vector2 = Vector2(0.5, 0.5)
@export var max_zoom: Vector2 = Vector2(4, 4)
var target_zoom: Vector2
var zoom_speed: float = 3
@export var zoom_factor: float = 1.1
var scale_factor: float = 4
var tolerance: float = 0.1


func _ready():
	target = get_parent()
	target_zoom = start_zoom
	target.zoom = start_zoom


func _process(delta):
	if abs(target.zoom.x - target_zoom.x) > tolerance:
		target.zoom = lerp(target.zoom, target_zoom, clampf(zoom_speed * delta, 0, 1))
		target.zoom = clamp(target.zoom, min_zoom, max_zoom)
	if not Global.input_disabled and Input.is_action_just_released("zoom_out"):
		target_zoom /= zoom_factor
	if not Global.input_disabled and Input.is_action_just_released("zoom_in"):
		target_zoom *= zoom_factor
	target_zoom = clamp(target_zoom, min_zoom, max_zoom)


func _zoom_in():
	target_zoom *= zoom_factor


func _zoom_out():
	target_zoom /= zoom_factor
