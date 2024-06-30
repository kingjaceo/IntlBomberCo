class_name InteractableButton
extends Button

var tween: Tween


#func _ready():
	#_highlight()


func _set(property, value):
	if property == "disabled" and value == false:
		_highlight()
	if property == "disabled" and value == true and tween and tween.is_running():
		modulate.v = 1
		tween.kill()


func _highlight():
	tween = get_tree().create_tween()
	tween.set_loops()
	while tween.is_running():
		tween.tween_property(self, "modulate:v", 10, 0.5)
		tween.tween_property(self, "modulate:v", 1, 0.5)
		await tween.finished
