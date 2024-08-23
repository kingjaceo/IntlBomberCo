class_name DockDetector
extends Area2D

var player: Player
var current_airship: AirshipData
#var first_frame: bool = true


func _ready():
	player = owner
	current_airship = player.current_airship
	area_entered.connect(_on_dock_detected)
	area_exited.connect(_on_undock)


func _on_dock_detected(dock: Dock):
	if not current_airship.docked:
		current_airship.world_position = owner.position
		current_airship.rotation = owner.rotation
		_dock(dock)
		SceneManager.open_town_menu()


#func _physics_process(_delta):
	#if first_frame:
		#var areas = get_overlapping_areas()
		#for area in areas:
			#if area is Dock:
				#current_airship.docked = true
				#break
		#first_frame = false


func _dock(dock: Dock):
	current_airship.world_position = dock.dock_point
	current_airship.rotation = dock.dock_orientation
	current_airship.docked = true


func _on_undock(dock: Dock):
	current_airship.docked = false
