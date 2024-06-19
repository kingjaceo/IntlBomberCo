class_name QuantityChanger
extends Node

@export var base_amount: float
@export var ctrl_multiplier: float
@export var ctrl_shift_multiplier: float


func _process(_delta):
	if Input.is_action_pressed("ctrl") and Input.is_action_pressed("shift"):
		get_parent().amount = base_amount * ctrl_shift_multiplier
	elif Input.is_action_pressed("ctrl"):
		get_parent().amount = base_amount * ctrl_multiplier
	else:
		get_parent().amount = base_amount
