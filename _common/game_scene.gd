class_name GameScene
extends CanvasItem

@export var time_scale: float = 1
signal scene_ready


func _ready():
	Engine.time_scale = time_scale
	Global.input_disabled = false
	scene_ready.emit()
