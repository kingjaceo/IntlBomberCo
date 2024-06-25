class_name PauseMenu
extends PanelContainer


@export_file var main_menu_scene_path: String
var main_menu_scene: PackedScene

signal main_menu_selected(scene: PackedScene)


func _ready():
	main_menu_scene = load(main_menu_scene_path)


func _on_resume_pressed():
	get_tree().paused = false
	hide()


func _on_main_menu_pressed():
	main_menu_selected.emit(main_menu_scene)


func _on_exit_pressed():
	get_tree().quit()
