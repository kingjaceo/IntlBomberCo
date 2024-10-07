class_name ObjectiveGridScene
extends GameScene

@onready var editor: ObjectiveGridEditor = %ObjectiveGridEditor
var objective_grids: Dictionary = { # {PlaceName: ObjectiveGrid}
	Enums.PlaceName.DARESH: preload("res://objectives/objective_grid/settlement_objective_grids/daresh_objectives.tres"),
	Enums.PlaceName.VITOK: preload("res://objectives/objective_grid/settlement_objective_grids/vitok_objectives.tres"),
	Enums.PlaceName.SABREK: preload("res://objectives/objective_grid/settlement_objective_grids/sabrek_objectives.tres"),
}


func _ready():
	_settlement_selected(0)


func _settlement_selected(index: int) -> void:
	editor.set_objective_grid(objective_grids[index])
