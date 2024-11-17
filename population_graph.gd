@tool
class_name PopulationGraph
extends CanvasItem

@export var size: Vector2i:
	set(value):
		size = value
		if Engine.is_editor_hint():
			_ready()
var plot_size: Vector2i
@export var pad: int = 8
@export var scale: Vector2 = Vector2(4, 4)
var populations_by_group: Dictionary = {}
var data: Dictionary = {}
var current_time: float = 0
var origin: Vector2
var max_time: float
var max_x: float
var min_y: float
var x_shift: float = 0.0
var colors_by_type: Dictionary = {"cricket": Color.GREEN, "frog": Color.YELLOW, "snake": Color.BLUE, "eagle": Color.RED}
@export_enum("SQUISH", "TRUNCATE") var mode: int

func _ready():
	get_tree().node_added.connect(_on_node_added)
	get_tree().node_removed.connect(_on_node_removed)
	origin = Vector2(pad, size.y - pad)
	max_time = size.x - 2 * pad
	for group in Global.creatures:
		populations_by_group[group] = len(get_tree().get_nodes_in_group(group))
		data[group] = []
	plot_size = size - 2*Vector2i(pad, pad)
	_regular_updates()


func _process(delta):
	current_time += delta
	if current_time > max_time:
		max_time = current_time
		x_shift += delta
	queue_redraw()


func _regular_updates():
	while true:
		await get_tree().create_timer(2.0).timeout
		for group in populations_by_group:
			_make_new_point(group)


func _on_node_added(node):
	var groups = node.get_groups()
	for group in groups:
		if group in populations_by_group:
			populations_by_group[group] += 1
			_make_new_point(group)


func _on_node_removed(node):
	var groups = node.get_groups()
	for group in groups:
		if group in populations_by_group:
			_make_new_point(group)


func _make_new_point(group: String):
	var new_point = Vector2(current_time, -populations_by_group[group])
	data[group].append(new_point)
	_check_update_scale(new_point)


func _check_update_scale(new_point: Vector2):
	if new_point.x > max_x:
		max_x = new_point.x
	if new_point.y < min_y:
		min_y = new_point.y
	var x_scale = min(plot_size.x / max_x, scale.x)
	var y_scale = min(-plot_size.y / min_y, scale.y)
	scale = Vector2(x_scale, y_scale)


func _draw():
	draw_rect(Rect2(-Vector2i(pad, pad)/2, size + Vector2i(pad, pad)), Color.BLACK)
	draw_rect(Rect2(Vector2.ZERO, size), Color("5b7c6c"))
	var old_pair = origin
	
	for type in data:
		if len(data[type]) > 0:
			old_pair = data[type][0]
		for pair in data[type]:
			var p1 = origin + old_pair * scale
			var p2 = origin + pair * scale
			draw_line(p1, p2, colors_by_type[type], 2.0)
			old_pair = pair

	draw_line(origin, Vector2(size.x - pad, origin.y), Color.BLACK, 2.0)
	draw_line(origin, Vector2(origin.x, pad), Color.BLACK, 2.0)
	draw_circle(origin, 2.0, Color.BLACK)
