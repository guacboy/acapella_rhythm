extends Node

# UI elements
signal on_combo_increment(increment: int)
signal on_score_increment(score: int)

# track elements
signal spawn_note(note_key: String, is_long_note: bool)
signal change_to_new_speed(speed: int)
