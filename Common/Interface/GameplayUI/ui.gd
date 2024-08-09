extends Control

@onready var combo_label = $Stats/ComboLabel

var current_combo: int = 0

func _ready() -> void:
	Signals.connect("on_combo_increment", _on_combo_increment)

func _on_combo_increment() -> void:
	current_combo += 1
	combo_label.text = str(current_combo) + "x"
