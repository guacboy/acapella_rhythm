extends Node2D

@export var key: String = ""

@onready var hit_sound = $HitSound
@onready var miss_sound = $MissSound
@onready var spotlights = $"../../Spotlights"

var is_perfect_note: bool = false
var is_good_note: bool = false
var is_okay_note: bool = false
var is_miss_note: bool = false

func _input(event) -> void:
	if event.is_action_pressed(key):
		play_spotlight_over_button(key)
		if is_perfect_note:
			print("perfect")
			Signals.emit_signal("on_combo_increment", true)
			Signals.emit_signal("on_score_increment", 300)
			Signals.emit_signal("on_life_change", 2.0)
			play_particles_after_note_hit("#2986cc") # sea blue
			play_text_status_after_note_hit("perfect")
			hit_sound.play()
		elif is_good_note:
			print("good")
			Signals.emit_signal("on_combo_increment", true)
			Signals.emit_signal("on_score_increment", 100)
			Signals.emit_signal("on_life_change", 1.0)
			play_particles_after_note_hit("#82dd59") # green
			play_text_status_after_note_hit("good")
			hit_sound.play()
		elif is_okay_note:
			print("okay")
			Signals.emit_signal("on_combo_increment", true)
			Signals.emit_signal("on_score_increment", 50)
			Signals.emit_signal("on_life_change", 0.5)
			play_particles_after_note_hit("#f2c845") # orange-yellow
			play_text_status_after_note_hit("okay")
			hit_sound.play()
		elif is_miss_note:
			print("miss")
			Signals.emit_signal("on_combo_increment", false)
			Signals.emit_signal("on_life_change", -1.0)
			play_text_status_after_note_hit("miss")
			miss_sound.play()

func play_spotlight_over_button(key: String) -> void:
	var tween := create_tween()
	for spotlight in spotlights.get_children():
		if key == spotlight.spotlight_key:
			tween.tween_property(spotlight, "color:a", 0.3, 0.1)
			tween.tween_property(spotlight, "color:a", 0.0, 0.25)

func play_particles_after_note_hit(color: String) -> void:
	var explosion_particle_instance := preload("res://Common/Particles/Explosion/explosion.tscn").instantiate()
	explosion_particle_instance.global_position = global_position
	explosion_particle_instance.color = Color.html(color)
	get_parent().add_child(explosion_particle_instance)

func play_text_status_after_note_hit(text: String) -> void:
	var text_status_instance := preload("res://Common/Particles/TextStatus/text_status.tscn").instantiate()
	text_status_instance.global_position = global_position
	text_status_instance.text = text
	get_parent().add_child(text_status_instance)
	
	var tween := create_tween().set_parallel()
	tween.tween_property(text_status_instance, "position:y", global_position.y - 25, 1.0)
	tween.tween_property(text_status_instance, "modulate:a", 0.0, 0.3)
	tween.finished.connect(text_status_instance.queue_free)

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
