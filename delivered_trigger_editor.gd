class_name DeliveredTriggerEditor
extends TriggerEditor

@onready var places: MultiSelector = %Places
@onready var items: MultiSelector = %Items


func _init():
	var trigger: DeliveredTrigger


func _ready():
	if trigger:
		for place in trigger.target_place_names:
			places.select(place)
		for item in trigger.target_item_types:
			items.select(item)
		%Amount.line_edit.text = str(trigger.target_amount)


#func _on_places_changed(index: int, selected: bool) -> void:
	#if selected and index not in trigger.target_place_names: # when a new item is selected, either alone or with ctrl
		## these need to be added to the target places
		#trigger.target_place_names.append(index)
		## either these needs to wipe the target places 
		## or append
	#else:
		#pass
		##trigger.target_place_names.append(index)
	# remove it if we need to
	#if not selected and index in trigger.target_place_names:
		#trigger.target_place_names.erase(index)
	## add it if we need to
	#if selected and index not in trigger.target_place_names:
		#trigger.target_place_names.append(index)


#func _on_items_changed(index: int, selected: bool) -> void:
	## remove it if we need to
	#if not selected and index in trigger.target_item_types:
		#trigger.target_item_types.erase(index)
	## add it if we need to
	#if selected and index not in trigger.target_item_types:
		#trigger.target_item_types.append(index)
#
#
#func _on_amount_changed(amount: int) -> void:
	#trigger.target_amount = amount
#
#
#func _on_item_selected(index: int) -> void:
	#trigger.target_item_types = [index]

#
#func _on_place_selected(index: int) -> void:
	#trigger.target_place_names = [index]


func _on_place_changed(place: int, checked: bool) -> void:
	if checked and place not in trigger.target_place_names:
		trigger.target_place_names.append(place)
	else:
		trigger.target_place_names.erase(place)


func _on_item_changed(item: int, checked: bool) -> void:
	if checked and item not in trigger.target_item_types:
		trigger.target_item_types.append(item)
	else:
		trigger.target_item_types.erase(item)
