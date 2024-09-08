class_name TriggerEditor
extends Control

@export var editor: PackedScene
@export var trigger: Trigger
var trigger_editors: Dictionary = {
	Enums.TriggerType.NONE: false,
	Enums.TriggerType.DELIVERED: load("res://objectives/triggers/delivered_trigger_editor.tscn")
}
#var triggers: Dictionary = {
	#Enums.TriggerType.NONE: false,
	#Enums.TriggerType.DELIVERED: DeliveredTrigger,
#}
var current_editor: TriggerEditor


func _ready():
	if editor:
		add_child(editor.instantiate())


func _on_trigger_selected(index: int) -> void:
	create_add_editor(index)


func create_add_editor(which: Enums.RewardType):
	if current_editor:
		remove_child(current_editor)
	var new_editor = trigger_editors[which]
	if new_editor:
		current_editor = new_editor.instantiate()
		#if not trigger:
			#trigger = triggers[which].new()
		current_editor.trigger = trigger
		add_child(current_editor)
