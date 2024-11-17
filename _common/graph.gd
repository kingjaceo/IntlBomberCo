@tool
class_name Graph
extends CanvasItem

@export var size: Vector2i:
	set(value):
		size = value
		if Engine.is_editor_hint():
			_ready()
var plot_size: Vector2i
@export var pad: int = 8
@export var scale: Vector2 = Vector2(4, 4)
@export var data_source: Node
var data: Variant
var points: Dictionary[Variant, Array]
var current_time: float = 0
var origin: Vector2
var max_time: float
var max_x: float
var min_y: float
var x_shift: float = 0.0
var colors
@export_enum("SQUISH", "TRUNCATE") var mode: int

func _ready():
	origin = Vector2(pad, size.y - pad)
	max_time = size.x - 2 * pad
	data = data_source.resources
	data.changed.connect(_make_new_points())
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
		_make_new_points()


func _make_new_points():
	for key in data.keys():
		_make_new_point(key)


func _make_new_point(key: Variant):
	var new_point = Vector2(current_time, -data.amount(key))
	points[key].append(new_point)
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
	
	for type in points.keys():
		if len(points[type]) > 0:
			old_pair = points[type][0]
		for pair in points[type]:
			var p1 = origin + old_pair * scale
			var p2 = origin + pair * scale
			draw_line(p1, p2, Enums.Colors[type], 2.0)
			old_pair = pair

	draw_line(origin, Vector2(size.x - pad, origin.y), Color.BLACK, 2.0)
	draw_line(origin, Vector2(origin.x, pad), Color.BLACK, 2.0)
	draw_circle(origin, 2.0, Color.BLACK)
