class_name TutorialContractDEPRECATED
extends Objective


func get_progress():
	return "Done" if completed else "Incomplete"


func get_description():
	return str(description)
