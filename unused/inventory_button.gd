@tool
class_name InventoryButtonDEPRECATED
extends Control

var active_button: bool = false
@onready var texture_button = %TextureButton
@onready var label = %Label
var item: GameItem:
	set(new_item):
		item = new_item
		_load_item()

signal pressed


func _ready():
	if item:
		_load_item()


func _load_item():
	texture_button.texture_normal = item.icon
	texture_button.mouse_entered.connect(_on_mouse_entered)
	texture_button.mouse_exited.connect(_on_mouse_exited)
	texture_button.pressed.connect(func (): pressed.emit())
	item.amount_changed.connect(_update_label)
	_update_label()


func _on_mouse_entered():
	if not active_button:
		modulate = Color.GRAY


func _on_mouse_exited():
	if not active_button:
		modulate = Color.WHITE


func _update_label():
	if item:
		label.text = item.name + " (" + str(item.amount) + ")"
