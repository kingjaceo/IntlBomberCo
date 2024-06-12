class_name TutorialCheckbox
extends CheckBox

var game_data: GameData

func _ready():
	game_data = Global.game_data
	button_pressed = game_data.tutorial_active
	pressed.connect(_on_toggle)


func _on_toggle():
	game_data.tutorial_active = not game_data.tutorial_active
