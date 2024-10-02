class_name GameMenu
extends GameScene


func _load_world():
	SceneManager.load_world()


func _reload():
	SceneManager.reload_current_scene()
	queue_free()


func _back_to_main():
	SceneManager.to_main_menu()


func _exit_game():
	get_tree().quit()


func _load_objective_grid_editor() -> void:
	SceneManager.load_objective_tree_editor()


func _load_battleground() -> void:
	SceneManager.load_battleground()
