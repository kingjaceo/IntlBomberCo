extends Node2D

@onready var surrounding_effects = %SurroundingEffects
@onready var main_strike = %MainStrike


func start(to: Vector2 = Vector2(0, 1)):
	surrounding_effects.emitting = true
	main_strike.emitting = true
