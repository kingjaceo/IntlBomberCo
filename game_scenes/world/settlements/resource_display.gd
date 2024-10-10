class_name ResourceDisplay
extends Control

var resources: Resources
var resource_type: String
var icon: Texture2D


func _ready():
	if resources:
		$ResourceType.text = resource_type
		$Amount.text = str(resources.amount(resource_type))
		$TextureRect.texture = icon


func _process(delta):
	if resources:
		$Amount.text = str(resources.amount(resource_type))
