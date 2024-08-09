extends Node2D

var is_perfect_note = false
var is_good_note = false
var is_okay_note = false
var is_miss_note = false

func _input(event) -> void:
	if event.is_action_pressed("j-key"):
		if is_perfect_note:
			print("perfect")
		elif is_good_note:
			print("good")
		elif is_okay_note:
			print("okay")
		elif is_miss_note:
			print("miss")

func _on_perfect_area_entered(area) -> void:
	if area.is_in_group("note"):
		is_perfect_note = true

func _on_perfect_area_exited(area):
	if area.is_in_group("note"):
		is_perfect_note = false

func _on_good_area_entered(area):
	if area.is_in_group("note"):
		is_good_note = true

func _on_good_area_exited(area):
	if area.is_in_group("note"):
		is_good_note = false

func _on_okay_area_entered(area):
	if area.is_in_group("note"):
		is_okay_note = true

func _on_okay_area_exited(area):
	if area.is_in_group("note"):
		is_okay_note = false

func _on_miss_area_entered(area):
	if area.is_in_group("note"):
		is_miss_note = true

func _on_miss_area_exited(area):
	if area.is_in_group("note"):
		is_miss_note = false
