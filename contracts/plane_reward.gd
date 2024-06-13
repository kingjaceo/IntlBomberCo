class_name PlaneReward
extends Reward

@export var airplane: Airplane

func receive():
	Global.game_data.add_plane(airplane)


func _to_string():
	return str(airplane)
