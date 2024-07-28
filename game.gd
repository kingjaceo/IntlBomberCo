class_name Game
extends Node2D

@onready var pause_menu = %PauseMenu
var game_data: GameData

var current_scene: PackedScene
var current_scene_instance: GameScene

#func _ready():
	#Utility.load_game_data("player_save.res")


#func _transition_to(scene: PackedScene):
	#await get_tree().process_frame
	#Utility.save_game_data("player_save.res")
	#
	#get_tree().paused = false
	#
	#if current_scene_instance:
		#current_scene_instance.queue_free()
		#
	#pause_menu.hide()
	#
	#_setup_and_load_new_scene(scene)


#func _process(_delta):
	#if Input.is_action_just_pressed("pause"): # and current_scene != start_menu:
		#if get_tree().paused:
			#get_tree().paused = false
			#pause_menu.hide()
		#else:
			#get_tree().paused = true
			#pause_menu.show()


#func _reload_current_scene():
	#_transition_to(current_scene)
#
#
#func _setup_and_load_new_scene(scene: PackedScene):
	#var new_scene = scene.instantiate()
	#add_child(new_scene)
	#
	#current_scene_instance = new_scene
	#current_scene = scene
	#current_scene_instance.transitioned_to.connect(_transition_to)
	#current_scene_instance.reloaded.connect(_reload_current_scene)
