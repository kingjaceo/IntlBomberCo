extends Node

var enemies: int = 0

func _ready():
	for c in get_tree().get_nodes_in_group('ai_ship'):
		enemies += 1
		c.tree_exited.connect(_decrease_enemy_count)


func _decrease_enemy_count():
	enemies -= 1
	if enemies <= 0 and is_instance_valid(owner):
		SceneManager.victory()
