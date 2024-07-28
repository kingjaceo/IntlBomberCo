extends Node


func format_number(amount: float, shorten=true) -> String:
	if shorten:
		return get_short_number(amount)
	else:
		return get_long_number(amount)


func get_short_number(amount: float):
	if amount <= 1000000:
		return get_long_number(amount)
	var integer: int = round(amount)
	var remainder: int = 0
	var thousands = 0
	if integer != 0:
		while integer > 1000:
			remainder = integer % 1000
			integer /= 1000
			thousands += 1
	else:
		return "0"
	if thousands == 1:
		return str(integer) + "," + "%03d" % remainder
	var letter = get_letter_shorthand(thousands)
	var short_number = str(integer) + letter
	return short_number


func get_long_number(amount):
	var integer: int = floor(amount)
	var decimal = amount - integer
	var formatted_number = ""
	if integer != 0:
		if integer >= 1000:
			formatted_number += str(floor(integer / 1000)) + ","
			integer %= 1000
		while integer >= 1000:
			var new_digits: int = floor(integer / 1000)
			formatted_number += "%03d" % new_digits + ","
			integer %= 1000
		formatted_number += "%03d" % integer
	else:
		formatted_number = "0" 
	formatted_number += "." + "%02d" % decimal
	return formatted_number


func get_letter_shorthand(thousands):
	match thousands:
		0: return ""
		2: return "m"
		3: return "b"
		4: return "t"


# if the number is less than 1m, show all digits
# if the number is more than 1m:
	# if the number is 1s or 10s, show 1 decimal place
	# if the number is 100s, show 0 decimal places
func format_money(amount: float) -> String:
	return "$ " + format_number(amount, true)


func rotate_to_target(subject: Node2D, target: Node2D, delta: float):
	var direction = (target.global_position - subject.global_position)
	var angle_to = subject.transform.x.angle_to(direction)
	subject.rotate(sign(angle_to) * min(delta * subject.rotation_speed, abs(angle_to)))


func get_screen_center(node: Node) -> Vector2:
	var viewport_rect = node.get_viewport().get_visible_rect()
	return viewport_rect.get_center()


func load_game_data(path: String):
	Global.game_data = ResourceLoader.load("res://game_data/player_game_data.tres")
	for contract in Global.game_data.contracts:
		if contract.accepted:
			contract.activate()


func save_game_data(path: String):
	ResourceSaver.save(Global.game_data)
