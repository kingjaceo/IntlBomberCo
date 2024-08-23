class_name Bomb
extends Node2D

@onready var sprite_2d = %Sprite2D
@onready var area_2d = %Area2D
@onready var shape = %CollisionShape2D
@export var explosion_effect: PackedScene
var item: BombItem


func _ready():
	shape.shape.radius = item.radius.value
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "scale", Vector2(0.1, 0.1), 2)
	await tween.finished
	
	_explode()


func _explode():
	var explosion = explosion_effect.instantiate()
	get_parent().add_child(explosion)
	explosion.position = position
	explosion.emitting = true
	var areas = area_2d.get_overlapping_areas()
	
	for area in areas:
		var target = area.get_parent()
		target.damage(item.damage.value)
	
	queue_free()
