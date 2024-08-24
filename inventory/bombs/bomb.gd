class_name Bomb
extends Node2D

@onready var sprite_2d = %Sprite2D
@onready var area_2d = %Area2D
@onready var shape = %CollisionShape2D
@export var explosion_effect: PackedScene
@export var damage_amount: float = 10
var _ready_to_explode: bool = false
var _areas: Array[Area2D]


func _ready():
	area_2d.area_entered.connect(_building_detected)
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale", Vector2(0.1, 0.1), 2)
	await tween.finished
	_explode.call_deferred()


func _building_detected(area: Area2D):
	_areas.append(area)


func _explode():
	var explosion = explosion_effect.instantiate()
	get_parent().add_child(explosion)
	explosion.position = position
	explosion.emitting = true
	
	for area in _areas:
		var target = area.get_parent()
		target.damage(damage_amount)
	
	queue_free()
