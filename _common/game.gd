class_name Game
extends Node2D

var game_data: GameData
@onready var blackscreen = %Blackscreen

var current_scene: PackedScene
var current_scene_instance: GameScene

func _ready():
	SceneManager.blackscreen = blackscreen
	SceneManager.to_main_menu()
