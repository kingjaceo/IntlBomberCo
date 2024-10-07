class_name GameMenu
extends Control

@export var time_scale: float = 0 # pause the game when active
@export var disable_input: bool = true # disable input


func _reload():
	SceneManager.reload_current_scene()


func _back_to_main():
	SceneManager.to_main_menu()


func _exit_game():
	get_tree().quit()


func _toggle():
	if visible:
		visible = false
		Engine.time_scale = 1
		Global.input_disabled = false
	else:
		visible = true
		Engine.time_scale = time_scale
		Global.input_disabled = disable_input
