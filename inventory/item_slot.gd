class_name ItemSlot
extends Panel

@onready var icon = %Icon
@onready var label = %Label
var amount: int:
	set(value):
		amount = value
		label.text = str(amount)

signal item_added(item: GameItem)
signal item_removed(item: GameItem)


func set_icon(texture: Texture):
	icon.texture = texture


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if has_node("Icon"):
		return false
	return true


func _drop_data(at_position: Vector2, item_icon: Variant):
	item_icon.get_parent().remove_child(item_icon)
	add_child(item_icon)
	item_icon.get_parent().item_removed.emit(item_icon.item)
	item_added.emit(item_icon.item)


func _get_drag_data(at_position: Vector2) -> Variant:
	if has_node("Icon"):
		var preview = _make_drag_preview(at_position)
		set_drag_preview(preview)
		return icon
	return null


func _make_drag_preview(at_position: Vector2):
	icon = get_node("Icon")
	var t = TextureRect.new()
	t.texture = icon.texture
	t.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.position = Vector2(-128, -128)
	t.modulate.a = 0.5
	var c = Control.new()
	c.add_child(t)
	return c
