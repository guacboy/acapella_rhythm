extends Node

# UI elements
signal on_combo_increment(increment: bool)
signal on_score_increment(score: int)

# track elements
signal spawn_note(note_key: String, is_long_note: bool)
signal set_speed(speed: int)

# life element
signal on_life_change(life: float)
