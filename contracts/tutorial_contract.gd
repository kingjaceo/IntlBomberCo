class_name TutorialContract
extends Contract


func activate():
	accepted = true
	upfront_reward.receive()


func complete():
	completion_reward.receive()


func get_progress():
	return "0 %"


func get_description():
	return "This contract is meaningless."
