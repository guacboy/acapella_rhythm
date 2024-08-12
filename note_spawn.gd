extends Marker2D

@export var note_connected_to: String = ""

func _ready() -> void:
	Signals.connect("spawn_note", _spawn_note)

# if the note_key matches with the note_connected_to, the note will spawn on that respective lane
# ex. note_key = "s-key" means it will spawn where the s-key column is (aka, the first lane)
func _spawn_note(note_key: String) -> void:
	if note_connected_to == note_key:
		var note_instance := preload("res://Common/Interface/Beats/note.tscn").instantiate()
		note_instance.key = note_key # assigns a note with its key (aka, detecting which lane it is in)
		add_child(note_instance)
