class_name CompanyPageTutorial
extends TutorialLogic


func _tutorial_logic():
	match current_step:
		0: # click Accept, contract goal: click on Buy
			focus = _first_contract_button()
		1: # click Buy Aid Package
			trigger =  get_parent().find_child("ItemColumn", true).find_child("Buy", true, false)
			trigger.pressed.connect(Global.game_data.contracts[0].satisfy_condition)
			focus = trigger
			focus.pressed.connect(_finish_step)
		2: # Complete Contract
			focus = _first_contract_button()
		3: # click Accept, contract goal: Drop an Aid Package
			await focus.tree_exited
			focus = _first_contract_button()
		4: # clock Launch Mission
			focus = get_parent().find_child("LaunchMission", true, false)
			focus.pressed.connect(_finish_step)
		5: # Complete Contract
			focus = _first_contract_button()
		6: # swap out tutorial_game_data for player_game_data
			Global.game_data = Global.player_game_data
			get_parent().reload()


func _first_contract_button():
		focus = get_parent().find_child("ContractColumn", true)
		focus = focus.find_child("Button", true, false)
		focus.pressed.connect(_finish_step)
		return focus
