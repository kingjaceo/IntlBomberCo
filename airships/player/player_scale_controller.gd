extends Sprite2D

var player: Player
var scale_factor: float = 4


func _ready():
	player = owner
	_scale_up()


func _scale_down():
	player.scale *= 1 / scale_factor


func _scale_up():
	player.scale *= scale_factor
