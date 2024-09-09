class_name ObjectiveLinkEditor
extends Control

enum Orientation {DOWN, RIGHT}
var objective_link: ObjectiveGridLink
@export var orientation: Orientation
@onready var link: Button = %Link
@onready var relink: Button = %Relink
@onready var remove: Button = %Remove
@onready var container: Container = %Container
var down_icon: Texture2D = load("res://icon.svg")
var right_icon: Texture2D = load("res://icon.svg")
var active: bool = false

signal add_link_pressed
signal removed


func _ready() -> void:
	if objective_link:
		link.visible = false
		remove.visible = true
		relink.visible = true
		container.visible = true
	else:
		link.visible = true
		remove.visible = false
		relink.visible = false
		container.visible = false
	link.pressed.connect(_link_pressed)
	if orientation == Orientation.DOWN:
		relink.icon = down_icon
	else:
		relink.icon = right_icon


func _link_pressed():
	link.visible = false
	relink.visible = true
	remove.visible = true
	container.visible = true
	add_link_pressed.emit()


func _on_remove_pressed() -> void:
	link.visible = true
	relink.visible = false
	remove.visible = false
	container.visible = false
	removed.emit()
