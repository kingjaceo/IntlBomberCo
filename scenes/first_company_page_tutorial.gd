class_name CompanyPageTutorial
extends TutorialLogic
# handles everything for this scene's tutorial,
# all manually coded


func _tutorial_logic():
	match current_step:
		0: # click Accept, contract goal: click on Buy
			focus = get_parent().find_child("ContractColumn", true)
			focus = focus.find_child("Button", true, false)
			focus.pressed.connect(_next_step)
			trigger =  get_parent().find_child("ItemColumn", true).find_child("Buy", true, false)
			trigger.pressed.connect(Global.game_data.contracts[0].satisfy_condition)
		1: # click Buy Aid Package
			focus = trigger
			focus.pressed.connect(_next_step)
		2: # Complete Contract
			focus = get_parent().find_child("ContractColumn", true)
			focus = focus.find_child("Button", true, false)
			focus.pressed.connect(_next_step)
		3: # click Accept, contract goal: Drop an Aid Package
			await focus.tree_exited
			focus = get_parent().find_child("ContractColumn", true)
			focus = focus.find_child("Button", true, false)
			focus.pressed.connect(_next_step)
		4: # clock Launch Mission
			focus = get_parent().find_child("LaunchMission", true, false)
			focus.pressed.connect(_next_step)
