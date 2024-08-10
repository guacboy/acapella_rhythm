extends Control

@onready var combo_label = $Stats/ComboLabel
@onready var score_label = $Stats/ScoreLabel

var current_combo: int = 0
var current_score: int = 0

func _ready() -> void:
	Signals.connect("on_combo_increment", _on_combo_increment)
	Signals.connect("on_score_increment", _on_score_increment)

func _on_combo_increment(increment: bool) -> void:
	if increment:
		current_combo += 1
	else:
		current_combo = 0 # combo break
		
	combo_label.text = str(current_combo) + "x"

func _on_score_increment(score: int) -> void:
	current_score += score * current_combo
	
	# allows for the zero placeholders on the left
	var zero_placeholder: String = ""
	if current_score >= 10000000:
		pass
	elif current_score >= 1000000:
		zero_placeholder = "0"
	elif current_score >= 100000:
		zero_placeholder = "00"
	elif current_score >= 10000:
		zero_placeholder = "000"
	elif current_score >= 1000:
		zero_placeholder = "0000"
	elif current_score >= 100:
		zero_placeholder = "00000"
	elif current_score >= 10:
		zero_placeholder = "000000"
	
	# if player reaches max score, the score will cap
	if current_score >= 99999999:
		current_score = 99999999

	score_label.text = zero_placeholder + str(current_score)
