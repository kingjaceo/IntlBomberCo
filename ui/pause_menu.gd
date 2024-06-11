class_name PauseMenu
extends PanelContainer

signal main_menu_selected


func _on_resume_pressed():
	get_tree().paused = false
	hide()


func _on_main_menu_pressed():
	main_menu_selected.emit()


func _on_exit_pressed():
	get_tree().quit()
