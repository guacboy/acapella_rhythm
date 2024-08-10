extends Control

@onready var combo_label = $Stats/ComboLabel

var current_combo: int = 0

func _ready() -> void:
	Signals.connect("on_combo_increment", _on_combo_increment)

func _on_combo_increment(increment: bool) -> void:
	if increment:
		current_combo += 1
	else:
		current_combo = 0 # combo break
		
	combo_label.text = str(current_combo) + "x"
