extends Node2D

@export var key: String = ""

@onready var note_spawn = $NoteSpawn

var is_perfect_note: bool = false
var is_good_note: bool = false
var is_okay_note: bool = false
var is_miss_note: bool = false

func _ready() -> void:
	spawn_note()

func _input(event) -> void:
	if event.is_action_pressed(key):
		if is_perfect_note:
			print("perfect")
			Signals.emit_signal("on_combo_increment", true)
			Signals.emit_signal("on_score_increment", 300)
			play_particles_after_note_hit("#2986cc") # sea blue
		elif is_good_note:
			print("good")
			Signals.emit_signal("on_combo_increment", true)
			Signals.emit_signal("on_score_increment", 100)
			play_particles_after_note_hit("#82dd59") # green
		elif is_okay_note:
			print("okay")
			Signals.emit_signal("on_combo_increment", true)
			Signals.emit_signal("on_score_increment", 50)
			play_particles_after_note_hit("#f2c845") # orange-yellow
		elif is_miss_note:
			print("miss")
			Signals.emit_signal("on_combo_increment", false)

func spawn_note() -> void:
	var note_instance := preload("res://Common/Interface/Beats/note.tscn").instantiate()
	note_instance.global_position = note_spawn.position
	add_child(note_instance)
	
func play_particles_after_note_hit(color: String) -> void:
	var explosion_particle_instance := preload("res://Common/Particles/Explosion/explosion.tscn").instantiate()
	explosion_particle_instance.global_position = global_position
	explosion_particle_instance.color = Color.html(color)
	get_parent().add_child(explosion_particle_instance)

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
