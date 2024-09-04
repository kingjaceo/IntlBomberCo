class_name PlayerItemDropper
extends Node

var items: Array[GameItem]
var active_item: GameItem
var player: Player

signal active_item_changed(item: GameItem)

func _ready():
	player = owner
	if Enums.player_airship_data:
		items = Enums.player_airship_data.items	


func _input(event):
	if event.is_action_pressed("1"):
		_try_set_active_item(0)
	if event.is_action_pressed("2"):
		_try_set_active_item(1)
	if event.is_action_pressed("3"):
		_try_set_active_item(2)
	if event.is_action_pressed("action") and active_item:
		_drop_active_item()


func _try_set_active_item(index: int):
	if len(items) > index:
		active_item = items[index]
		active_item_changed.emit(active_item)


func _drop_active_item():
	if active_item.amount > 0:
		active_item.amount -= 1
		var new_item = active_item.scene.instantiate()
		get_parent().get_parent().add_child(new_item)
		new_item.position = player.position
