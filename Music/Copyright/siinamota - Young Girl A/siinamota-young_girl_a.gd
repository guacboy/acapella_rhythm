extends Node

@onready var trackID = $"."
@onready var next_iteration_delay = $NextIterationDelay

# the higher the tempo, the lower the delay must be to be consistent;
# delay = 0.5 / tempo
var note_list := {
	0: {
		"is_new_tempo": true,
		"tempo": 4,
		"next_iteration_delay": 1.0,
		"note": [
			"s-key",
			"d-key",
			"f-key",
		]
	},
	1: {
		"is_new_tempo": false,
		"tempo": 2,
		"next_iteration_delay": 1.0,
		"note": [
			"j-key",
			"k-key",
			"l-key",
		]
	},
}

var current_idx: int = 0 # current note block; must manually align with starting_position_of_song
var note_list_idx = note_list[current_idx]
var starting_position_of_song: float = 0.0 # current position of song

func _ready() -> void:
	trackID.play(starting_position_of_song)
	
	play_note(note_list_idx["note"])

func play_note(note) -> void:
	for i in note:
		Signals.emit_signal("spawn_note", i)
		Signals.emit_signal("change_to_new_speed", note_list_idx["tempo"])
		if note_list_idx["is_new_tempo"]:
			await get_tree().create_timer(0.5 / note_list_idx["tempo"]).timeout
	
	# continues looping until the end of the note_list
	if current_idx < len(note_list) - 1:
		next_iteration_delay.wait_time = note_list_idx["next_iteration_delay"] # delays next note block
		current_idx += 1
		next_iteration_delay.start()

func _on_next_iteration_delay_timeout():
	note_list_idx = note_list[current_idx]
	play_note(note_list_idx["note"])
