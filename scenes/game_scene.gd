class_name GameScene
extends Node2D

@export_file var transition_scene_path: String
var transition_scene: PackedScene
var game_data: GameData

signal transitioned_to(scene: GameScene)
signal reloaded


func _ready():
	transition_scene = load(transition_scene_path)
	game_data = Global.game_data


func _transition():
	transitioned_to.emit(transition_scene)


func _exit():
	get_tree().quit()


func reload():
	reloaded.emit()
