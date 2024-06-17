class_name TutorialLogic
extends Node

@export var tutorial_name: String
@export var current_step: int = 0
var focus: Control
var trigger: Control
var tween: Tween


func _ready():
	if Global.game_data.tutorial_active:
		current_step = Tutorial.current_tutorial_steps[tutorial_name]
		_next_step()
	else:
		queue_free()


func _next_step():
	Tutorial.current_tutorial_steps[tutorial_name] = current_step + 1
	_disconnect_focus()
	_kill_highlight()
	await _tutorial_logic()	
	_highlight_focus()
	current_step += 1


func _disconnect_focus():
	if focus:
		focus.modulate.v = 1
		var signals = focus.get_signal_list()
		for s in signals:
			if focus.is_connected(s.name, _next_step):
				focus.disconnect(s.name, _next_step) 


func _highlight_focus():
	if focus:
		tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_loops()
		while tween.is_running():
			tween.tween_property(focus, "modulate:v", 10, 0.5).from(1)
			tween.tween_property(focus, "modulate:v", 1, 0.5).from(10)
			await tween.finished


func _tutorial_logic():
	pass


func _kill_highlight():
	if tween:
		tween.kill()
