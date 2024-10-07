class_name ResourceDisplay
extends Control

var resources: Dictionary
var resource_type: Enums.ResourceType
var icon: Texture2D


func _ready():
	if resources:
		$ResourceType.text = str(Enums.ResourceType.keys()[resource_type])
		$Amount.text = str(resources[resource_type])
		$TextureRect.texture = icon

func _process(delta):
	if resources:
		$Amount.text = str(resources[resource_type])
