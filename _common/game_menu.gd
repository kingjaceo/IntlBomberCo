class_name GameMenu
extends CanvasItem


func _load_world():
	SceneManager.load_world()


func _reload():
	get_tree().reload_current_scene()
	queue_free()


func _back_to_main():
	SceneManager.to_main_menu()


func _exit_game():
	get_tree().quit()
