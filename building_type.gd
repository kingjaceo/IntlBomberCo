class_name BuildingType
extends Resource

enum BuildingType {RESIDENTIAL = 1, COMMERCIAL = 2, INDUSTRIAL = 4, MILITARY = 8}
@export_flags("Residential", "Commercial", "Industrial", "Military") var building_type:
	set(value):
		building_type = value
