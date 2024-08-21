class_name GameScene
extends Node2D

var game_data: GameData
signal transitioned_to(scene: GameScene)
signal reloaded


func _ready():
	game_data = Global.game_data


func _transition():
	SceneManager.load_world()


func _exit():
	get_tree().quit()


func reload():
	reloaded.emit()


func _on_area_2d_area_entered():
	pass # Replace with function body.
