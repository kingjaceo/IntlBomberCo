class_name EnumSelector
extends OptionButton

@export var selection: Enums.AllEnums


func _ready():
	var enums = Enums.AllEnumsDict[selection]
	clear()
	for item in enums:
		add_item(item)


#func select(item: int):
	#var button = container.get_child(item)
	#button.set_pressed_no_signal(true)
	##.button_pressed = true
#
#
#func _add_check_box(item: int):
	#var new_check_box = CheckBox.new()
	#new_check_box.text = Enums.AllEnumsDict[selection].keys()[item]
	#new_check_box.toggled.connect(_item_toggled.bind(item))
	#container.add_child(new_check_box)
#
#
#func _item_toggled(toggled_on: bool, item: int):
	#item_changed.emit(item, toggled_on)
#func _on_line_edit_text_changed(new_text):
	#if regex.search(new_text):
		#line_edit.text = new_text
		#oldtext = new_text
	#else:
		#line_edit.text = oldtext
	#line_edit.set_caret_column(line_edit.text.length())
	#quantity_changed.emit(int(line_edit.text))