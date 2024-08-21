class_name SettlementBoundary
extends Area2D


func _ready():
	area_entered.connect(_on_player_entered)


func _on_player_entered():
	Global.current_settlement = owner
