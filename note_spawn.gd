extends Marker2D

@export var note_connected_to: String = ""

func _ready() -> void:
	connect_note_to_key("s-key")
	connect_note_to_key("j-key")
		
func connect_note_to_key(note: String) -> void:
	if note_connected_to == note:
		spawn_note()

func spawn_note() -> void:
	var note_instance := preload("res://Common/Interface/Beats/note.tscn").instantiate()
	add_child(note_instance)
