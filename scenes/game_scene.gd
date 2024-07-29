class_name GameScene
extends Node2D

@export_file var transition_scene_path: String
var transition_scene: PackedScene
var game_data: GameData
signal transitioned_to(scene: GameScene)
signal reloaded


func _ready():
	if transition_scene_path:
		transition_scene = load(transition_scene_path)
	game_data = Global.game_data


func _transition():
	Global.transition_to(transition_scene)


func _exit():
	get_tree().quit()


func reload():
	reloaded.emit()


func _on_area_2d_area_entered():
	pass # Replace with function body.
