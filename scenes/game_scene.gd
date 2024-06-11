class_name GameScene
extends Node2D

@export var scene_name: String
var game_data: GameData

signal transitioned_to(scene: GameScene)


func _ready():
	game_data = Global.game_data


func _transition():
	transitioned_to.emit(scene_name)
	pass

func _exit():
	get_tree().quit()
