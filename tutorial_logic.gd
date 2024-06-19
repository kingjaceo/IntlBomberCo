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
		_start_step()
	else:
		queue_free()


func _start_step():
	await _tutorial_logic()
	_highlight_focus()


func _finish_step():
	_disconnect_focus()
	_kill_highlight()
	current_step += 1
	Tutorial.current_tutorial_steps[tutorial_name] = current_step
	_start_step()


func _disconnect_focus():
	if focus:
		focus.modulate.v = 1
		var signals = focus.get_signal_list()
		for s in signals:
			if focus.is_connected(s.name, _finish_step):
				focus.disconnect(s.name, _finish_step) 


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
