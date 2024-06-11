extends Camera2D

@export var target: Node2D
#@export var max_distance: float = 500
#@export var camera_speed: float = 50
#@export var camera_acceleration: float = 5
#@export var min_x: float = 0
#@export var max_x: float = 2000
#@export var min_y: float = 0
#@export var max_y: float = 1000

#var target_x: float
#var target_y: float


#func _ready():
	#position.x = target.position.x
	#position.y = target.position.y


#func _process(delta):
	#position.y = lerp(position.y, target.position.y, 0.9)
	#position.x = lerp(position.x, target.position.x, 0.9)
	#target_y = lerp(target_y, target.position.y, 0.5)
	#target_x = lerp(target_x, target.position.x, 0.5)
	#clampf(position.y, min_y, max_y)
	#clampf(position.x, min_x, max_x)

#
#func _unhandled_input(event):
	#var current_y_distance = abs(target.position.y - target_y)
	#if event.is_action("up") and current_y_distance < max_distance:
		#target_y -= camera_acceleration * camera_acceleration
	#if event.is_action("down") and current_y_distance < max_distance:
		#target_y += camera_acceleration * camera_acceleration

