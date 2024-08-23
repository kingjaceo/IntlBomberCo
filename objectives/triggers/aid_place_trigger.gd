class_name AidPlaceTrigger
extends AidTrigger

@export var target_place_name: Global.PlaceName

func activate():
	Events.aid_delivered.connect(_on_aid_delivered)


func _on_aid_delivered(location: Vector2, place: Global.PlaceName):
	if place == target_place_name:
		super._on_aid_delivered(location, place)
