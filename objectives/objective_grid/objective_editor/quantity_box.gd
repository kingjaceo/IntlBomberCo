@tool
class_name QuantityBox
extends Control

@export var label_text: String:
	set(value):
		label_text = value
		if label:
			label.text = label_text
@onready var label: Label = %Label
@onready var line_edit: LineEdit = %LineEdit
var regex = RegEx.new()
var oldtext = ""

signal quantity_changed(amount: int)


func _ready():
	if label_text:
		label.text = label_text
	regex.compile("^[0-9]*$")


func _on_line_edit_text_changed(new_text):
	if regex.search(new_text):
		line_edit.text = new_text
		oldtext = new_text
	else:
		line_edit.text = oldtext
	line_edit.set_caret_column(line_edit.text.length())
	quantity_changed.emit(int(line_edit.text))
