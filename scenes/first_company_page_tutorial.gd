extends Node
# handles everything for this scene's tutorial,
# all manually coded

@export var current_step_number: int = 0
var focus: Control
var trigger: Control


func _ready():
	_next_step()


func _next_step():
	_disconnect_focus()
	if focus: focus.modulate.v = 1
	
	match current_step_number:
		0: # click Accept, contract goal: click on Buy
			focus = get_parent().find_child("ContractColumn", true)
			focus = focus.find_child("Button", true, false)
			focus.pressed.connect(_next_step)
			#focus.modulate.v = 15
			trigger =  get_parent().find_child("ItemColumn", true).find_child("Buy", true, false)
			trigger.pressed.connect(Global.game_data.contracts[0].complete)
		1: # click Buy Aid Package
			focus = trigger
			focus.pressed.connect(_next_step)
		2: # Complete Contract
			pass
		3: # click Accept, contract goal: Launch mission
			pass
			
	focus.modulate.v = 15
	current_step_number += 1


func _disconnect_focus():
	if focus:
		var signals = focus.get_signal_list()
		for s in signals:
			if focus.is_connected(s.name, _next_step):
				focus.disconnect(s.name, _next_step) 
