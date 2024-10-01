extends Node2D

@onready var beehave_tree = %BeehaveTree
var blackboard: Blackboard


func _ready():
	blackboard = beehave_tree.blackboard
