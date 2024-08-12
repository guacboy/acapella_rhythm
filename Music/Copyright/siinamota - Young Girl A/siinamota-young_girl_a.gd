extends Node

@onready var track = $"."

var note_list := {
	1: {
		"tempo": 5,
		"note": [
			"s-key",
			"d-key",
			"f-key",
		]
	}
}

var note_list_idx = note_list[1] # allows for jumping between different parts of the song

func _ready() -> void:
	#track.play()
	
	play_note(note_list_idx["note"])

func play_note(note) -> void:
	for i in note:
		Signals.emit_signal("spawn_note", i)
		Signals.emit_signal("change_to_new_speed", note_list_idx["tempo"])
		await get_tree().create_timer(0.5).timeout
