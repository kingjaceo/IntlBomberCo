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
