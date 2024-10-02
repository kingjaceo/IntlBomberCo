class_name GameScene
extends CanvasItem

@export var time_scale: float = 1
@export var menus: CanvasLayer
@onready var game_over_screen: GameMenu = %GameOverScreen
@onready var victory_screen: GameMenu = %VictoryScreen
signal scene_ready


func _ready():
	Engine.time_scale = time_scale
	scene_ready.emit()


func show_game_over():
	game_over_screen.visible = true


func show_victory():
	victory_screen.visible = true
