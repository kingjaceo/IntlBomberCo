class_name Game
extends Node2D

@onready var pause_menu = %PauseMenu
@onready var start_menu = %StartMenu
var game_data: GameData

var current_scene: Node2D


func _ready():
	game_data = Global.game_data
	current_scene = start_menu
	start_menu.transitioned_to.connect(_transition_to)


func _transition_to(scene: PackedScene):
	await get_tree().process_frame
	if current_scene != scene:
		current_scene.queue_free()
		pause_menu.hide()
		var new_scene = scene.instantiate()
		new_scene.game_data = game_data
		add_child(new_scene)
		current_scene = new_scene
		new_scene.transitioned_to.connect(_transition_to)


func _process(_delta):
	if Input.is_action_just_pressed("pause") and current_scene != start_menu:
		if get_tree().paused:
			get_tree().paused = false
			pause_menu.hide()
		else:
			get_tree().paused = true
			pause_menu.show()
