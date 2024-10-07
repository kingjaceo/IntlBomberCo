class_name MovementController
extends Node

@export var speed: float = 300
@export var dash_factor: float = 5
var target: Node2D
var target_direction: Vector2


func _ready():
	target = get_parent()


func _process(delta):
	if Input.is_action_pressed("up"):
		target_direction += Vector2(0, -1)
	if Input.is_action_pressed("down"):
		target_direction += Vector2(0, 1)
	if Input.is_action_pressed("left"):
		target_direction += Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		target_direction += Vector2(1, 0)
	target_direction = target_direction.normalized()
	if Input.is_action_pressed("dash"):
		target_direction *= dash_factor
	target.position += target_direction * speed * delta
	target_direction = Vector2.ZERO
