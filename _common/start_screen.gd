class_name StartScreen
extends GameScene


func _load_world():
	SceneManager.load_world()


func _load_objective_grid_editor() -> void:
	SceneManager.load_objective_tree_editor()


func _load_battleground() -> void:
	SceneManager.load_battleground()


func _load_observer_world():
	SceneManager.load_observer_world()
