extends Node2D

var is_perfect_note: bool = false
var is_good_note: bool = false
var is_okay_note: bool = false
var is_miss_note: bool = false

func _input(event) -> void:
	if event.is_action_pressed("j-key"):
		if is_perfect_note:
			print("perfect")
			Signals.emit_signal("on_combo_increment")
			play_particles_after_note_hit("perfect")
		elif is_good_note:
			print("good")
		elif is_okay_note:
			print("okay")
		elif is_miss_note:
			print("miss")
			
func play_particles_after_note_hit(color: String) -> void:
	var explosion_particle := preload("res://Common/Particles/Explosion/explosion.tscn").instantiate()
	explosion_particle.global_position = global_position
	get_parent().add_child(explosion_particle)

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
