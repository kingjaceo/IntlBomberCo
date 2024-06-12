extends Node


func format_number(amount: float) -> String:
	var integer: int = floor(amount)
	var decimal = amount - integer
	var formatted_number = ""
	if integer >= 1000:
		formatted_number += str(floor(integer / 1000)) + ","
		integer %= 1000
	while integer >= 1000:
		var new_digits: int = floor(integer / 1000)
		formatted_number += "%03d" % new_digits + ","
		integer %= 1000
	formatted_number += "%03d" % integer
	formatted_number += "." + "%02d" % decimal
	return formatted_number


func format_money(amount: float) -> String:
	return "$ " + format_number(amount)


func rotate_to_target(subject: Node2D, target: Node2D, delta: float):
	var direction = (target.global_position - subject.global_position)
	var angle_to = subject.transform.x.angle_to(direction)
	subject.rotate(sign(angle_to) * min(delta * subject.rotation_speed, abs(angle_to)))


func get_screen_center(node: Node) -> Vector2:
	var viewport_rect = node.get_viewport().get_visible_rect()
	return viewport_rect.get_center()
