class_name GameScene
extends CanvasItem

signal scene_ready


func _ready():
	scene_ready.emit()
