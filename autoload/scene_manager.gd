extends Node

var main_menu: PackedScene = load("res://_common/start_menu.tscn")
var credit_screen: PackedScene = load("res://_common/credit_screen.tscn")
var victory_screen: PackedScene = load("res://_common/victory_screen.tscn")
var game_over_screen: PackedScene = load("res://_common/game_over_screen.tscn")
var world: PackedScene = load("res://world/world.tscn")
var town_menu: PackedScene = load("res://town_screen/town_screen.tscn")
var menus: CanvasLayer


func transition_to(scene: PackedScene):
	get_tree().paused = false
	get_tree().change_scene_to_packed.call_deferred(scene)


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
