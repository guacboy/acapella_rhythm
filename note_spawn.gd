extends Marker2D

@export var note_connected_to: String = ""

func _ready() -> void:
	connect_note_to_key("s-key")
	connect_note_to_key("f-key")

# if the note_key matches with the note_connected_to, the note will spawn on that respective lane
# ex. note_key = "s-key" means it will spawn where the s-key column is (aka, the first lane)
func connect_note_to_key(note_key: String) -> void:
	if note_connected_to == note_key:
		spawn_note(note_key)

func spawn_note(note_key: String) -> void:
	var note_instance := preload("res://Common/Interface/Beats/note.tscn").instantiate()
	note_instance.key = note_key
	add_child(note_instance)
