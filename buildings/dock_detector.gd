class_name DockDetector
extends Area2D


func _ready():
	owner = get_parent()
	area_entered.connect(_on_dock_detected)


func _on_dock_detected(area: Area2D):
	owner.forward_speed = 0
	SceneManager.open_town_menu()
