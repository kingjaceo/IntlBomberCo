extends Node

@warning_ignore("unused_signal")
signal building_destroyed(building_type: int)
signal aid_delivered(location: Vector2, place: Enums.PlaceName)
signal item_purchased(item: Enums.ItemType)
signal item_delivered(place_name: Enums.PlaceName, item_type: Enums.ItemType, amount: float)
signal victory
signal game_over
