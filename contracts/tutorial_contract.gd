class_name TutorialContract
extends Contract


func activate():
	accepted = true
	upfront_reward.receive()


func complete():
	completion_reward.receive()


func get_progress():
	return "Done" if completed else "Incomplete"


func get_description():
	return str(description)
