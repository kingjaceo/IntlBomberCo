extends Node

var main_menu: PackedScene = load("res://_common/start_menu.tscn")
var credit_screen: PackedScene = load("res://_common/credit_screen.tscn")
var victory_screen: PackedScene = load("res://_common/victory_screen.tscn")
var game_over_screen: PackedScene = load("res://_common/game_over_screen.tscn")
var world: PackedScene = load("res://world/world.tscn")
var town_menu: PackedScene = load("res://town_screen/town_screen.tscn")
var menus: CanvasLayer
var blackscreen
var current_scene


func transition_to(scene: PackedScene):
	#_fade_in_out(3.0)
	#_toggle_blackscreen()
	await _load_scene(scene)
	await get_tree().create_timer(0.1).timeout
	#_toggle_blackscreen()


func _fade_in_out(length: float):
	var tween = get_tree().create_tween()
	blackscreen.visible = false
	blackscreen.modulate.a = 0.0
	tween.tween_property(blackscreen, "modulate:a", 1, 0.1)
	await tween.finished
	tween.tween_property(blackscreen, "modulate:a", 0, 0.1)
	await tween.finished
	blackscreen.visible = false
	
func _toggle_blackscreen():
	if blackscreen:
		blackscreen.visible = not blackscreen.visible


func _load_scene(scene:PackedScene) -> void:
	if current_scene:
		current_scene.queue_free()
	
	var scene_instance: GameScene = scene.instantiate()
	get_tree().root.call_deferred("add_child",scene_instance)
	get_tree().set_deferred("current_scene",scene_instance)
	current_scene = scene_instance
	await scene_instance.scene_ready
	#var loader = ResourceLoader.load_threaded_request(scene)
	#if not ResourceLoader.exists(content_path) or loader == null:
		#content_invalid.emit(content_path)
		#return 		
	
	#_load_progress_timer = Timer.new()
	#_load_progress_timer.wait_time = 0.1
	#_load_progress_timer.timeout.connect(monitor_load_status)
	#get_tree().root.add_child(_load_progress_timer)
	#_load_progress_timer.start()


## specific transitions ##
func to_main_menu():
	transition_to(main_menu)


func load_world():
	transition_to(world)


func open_town_menu():
	transition_to(town_menu)


func load_credit_screen():
	transition_to(credit_screen)


func game_over():
	transition_to(game_over_screen)


func victory():
	transition_to(victory_screen)
