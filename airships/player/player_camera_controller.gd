extends Camera2D

var player: Player
var current_airship: AirshipData
@export var start_zoom: Vector2 = Vector2(0.75, 0.75)
var target_zoom: Vector2
var zoom_speed: float = 3
@export var zoom_factor: float = 3
var scale_factor: float = 4
var tolerance: float = 0.01


func _ready():
	target_zoom = start_zoom
	zoom = start_zoom
	player = owner
	current_airship = player.current_airship
	if not current_airship.at_site:
		_zoom_out()


func _process(delta):
	if abs(zoom.x - target_zoom.x) > tolerance:
		zoom = lerp(zoom, target_zoom, clampf(zoom_speed*delta, 0, 1))


func _zoom_in():
	target_zoom *= zoom_factor


func _zoom_out():
	target_zoom /= zoom_factor


func _on_site_entered(area: Area2D):
	if not current_airship.docked:
		_zoom_in()
		var settlement = area.owner
		Global.current_settlement_data = settlement.data


func _on_site_exited(area: Area2D):
	_zoom_out()
