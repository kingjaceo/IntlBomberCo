extends Node


signal building_destroyed(building_type: int)
signal aid_delivered(location: Vector2, place: Global.PlaceName)
signal item_purchased(item: Global.ItemType)
signal item_delivered(place_name: Global.PlaceName, item_type: Global.ItemType, amount: float)
