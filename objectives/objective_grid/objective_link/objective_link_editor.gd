class_name ObjectiveLinkEditor
extends Control

enum Orientation {DOWN, RIGHT}
@export var orientation: Orientation
@onready var link: Button = %Link
@onready var unlink: Button = %Unlink
@onready var container: Container = %Container
var down_icon: Texture2D = load("res://icon.svg")
var right_icon: Texture2D = load("res://icon.svg")
var active: bool = false
var trigger: Trigger

signal add_link_pressed


func _ready() -> void:
	if active:
		link.visible = false
		unlink.visible = true
		container.visible = true
	else:
		link.visible = true
		unlink.visible = false
		container.visible = false
	link.pressed.connect(_link_pressed)
	if orientation == Orientation.DOWN:
		unlink.icon = down_icon
	else:
		unlink.icon = right_icon


func _link_pressed():
	link.visible = false
	unlink.visible = true
	container.visible = true
	add_link_pressed.emit()
