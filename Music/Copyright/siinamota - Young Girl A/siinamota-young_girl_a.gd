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

func _ready() -> void:
	#track.play()
	
	var note_list_idx = note_list[1] # allows for jumping between different parts of the song
	Signals.emit_signal("change_to_new_speed", note_list_idx["tempo"])
	play_note(note_list_idx["note"])
	print(note_list_idx["tempo"])

func play_note(note) -> void:
	for i in note:
		Signals.emit_signal("spawn_note", i)
		await get_tree().create_timer(0.5).timeout
