class_name LightningStriker
extends Node2D

var charge_ready: bool = true
@export var damage: float # points of health
@export var recharge_time: float # seconds
@export var range: int # pixels
@onready var lightning_strike = %LightningStrike # strike effect (eg, particle scene)
var target: Node2D


func _ready():
	get_parent().get_blackboard().set_value("attack_range", range)


func _process(delta):
	if is_instance_valid(owner.target):
		target = owner.target
		var direction = target.position - owner.position
		var forward = owner.transform.x
		var angle = forward.angle_to(direction) - PI/2
		rotation = angle
		var distance = direction.length()
		_stretch_to_target(target.position, distance)
		if distance < range and charge_ready:
			charge_ready = false
			_strike()
			await get_tree().create_timer(recharge_time).timeout
			charge_ready = true


func _strike():
	if target.has_method('damage'):
		var actual_damage = damage * owner.power_levels['lightning']
		if actual_damage > 0:
			lightning_strike.start(target.position)
			target.damage(actual_damage)


func _stretch_to_target(target_position: Vector2, distance: float):
	var scale_factor = 512
	scale.y = distance / scale_factor
