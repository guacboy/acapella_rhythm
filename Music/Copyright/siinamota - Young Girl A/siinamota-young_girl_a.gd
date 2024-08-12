extends Node

@onready var trackID = $"."
@onready var next_iteration_delay = $NextIterationDelay
@onready var offset = $Offset

# is_new_tempo: toggle for delay between each note -
# false = all notes, same row; true = notes play at different row
# tempo: controls the speed of each note
# is_next_iteration_delay: toggle for delay for next iteration block
# next_iteration_delay: controls the delay between playing the next iteration block
# note: where the magic happens
var note_list := {
	0: {
		"is_new_tempo": true,
		"tempo": 6,
		"is_next_iteration_delay": true,
		"next_iteration_delay": 1.0,
		"note": [
			"s-key",
			"d-key",
			"f-key",
		]
	},
	1: {
		"is_new_tempo": true,
		"tempo": 6,
		"is_next_iteration_delay": false,
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
	play_note(note_list_idx["note"])
	offset.wait_time = 1.75 # delay for starting the song (to align notes vs button)
	offset.start()

func play_note(note) -> void:
	for i in note:
		Signals.emit_signal("spawn_note", i)
		Signals.emit_signal("change_to_new_speed", note_list_idx["tempo"])
		if note_list_idx["is_new_tempo"]:
			await get_tree().create_timer(0.5 / note_list_idx["tempo"]).timeout
	
	# continues looping until the end of the note_list
	if current_idx < len(note_list) - 1:
		current_idx += 1
		
		# if there is no iteration delay, play next note block
		if not note_list_idx["is_next_iteration_delay"]:
			note_list_idx = note_list[current_idx]
			play_note(note_list_idx["note"])
		
		# if there is an iteration delay, start timer to play next note block
		if note_list_idx["is_next_iteration_delay"]:
			var previous_note_list_idx = note_list[current_idx - 1]
			next_iteration_delay.wait_time = previous_note_list_idx["next_iteration_delay"]
			next_iteration_delay.start()

func _on_next_iteration_delay_timeout():
	note_list_idx = note_list[current_idx]
	play_note(note_list_idx["note"])

func _on_offset_timeout():
	trackID.play(starting_position_of_song)
