class_name SiteDetector
extends Area2D

var player: Player
var current_airship: AirshipData


func _ready():
	player = owner
	current_airship = player.current_airship
	var areas = get_overlapping_areas()
	if len(areas) > 0:
		current_airship.at_site = true
	area_entered.connect(_on_site_detected)
	area_exited.connect(_on_site_left)


func _on_site_detected(area: Area2D):
	current_airship.at_site = true


func _on_site_left(area: Area2D):
	current_airship.at_site = false
