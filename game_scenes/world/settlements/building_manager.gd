class_name BuildingManager
extends Node2D

#signal resources_produced(resources: Resources)


#func _ready():
	#for c in get_children():
		#c.resources_produced.connect(_resources_produced)
#
#
#func _resources_produced(resources):
	#resources_produced.emit(resources)
