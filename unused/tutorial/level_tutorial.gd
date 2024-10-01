class_name LevelTutorial
extends TutorialLogic

var time_pressed: float = 0
var time_required: float = 0.4

func _process(delta):
	if current_step == 0 and Input.is_action_pressed("down"):
		_update_time(delta)
	if current_step == 1 and Input.is_action_pressed("up"):
		_update_time(delta)
	if current_step in [2, 5] and Input.is_action_pressed("action"):
		_finish_step()
	if current_step == 3 and Input.is_action_pressed("left"):
		_update_time(delta)
	if current_step == 4 and Input.is_action_pressed("right"):
		_update_time(delta)


func _update_time(delta):
	time_pressed += delta
	if time_pressed >= time_required:
		_finish_step()


func _tutorial_logic():
	if focus:
		focus.visible = false
	
	match current_step:
		0: # display "S" until player holds it for 0.25s
			focus = get_parent().find_child("PlayerPlane", true).find_child("S", true)
			focus.visible = true
			time_pressed = 0
		1: # display "W" until player holds it for 0.25s
			focus = get_parent().find_child("PlayerPlane", true).find_child("W", true)
			focus.visible = true
			time_pressed = 0
		2: # display "Space" until player presses it once
			focus = get_parent().find_child("PlayerPlane", true, false).find_child("Panel", true)
			_highlight_focus()
			focus = get_parent().find_child("PlayerPlane", true).find_child("Space", true)
			focus.visible = true
		3: # display "A"
			focus = get_parent().find_child("PlayerPlane", true).find_child("A", true)
			focus.visible = true
			time_pressed = 0
		4: # display "D"
			focus = get_parent().find_child("PlayerPlane", true).find_child("D", true)
			focus.visible = true
			time_pressed = 0
		5: # display "Space" again
			focus = get_parent().find_child("PlayerPlane", true).find_child("Space", true)
			focus.visible = true
		6: # End Mission
			focus = get_parent().find_child("CompanyPage", true)
			focus.visible = true
	Tutorial.current_tutorial_steps["Level"] = current_step
			
