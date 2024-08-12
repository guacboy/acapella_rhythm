extends Node2D

@export var key: String = ""

var is_on_button: bool = false
var note_speed: int = 0

func _ready() -> void:
	Signals.connect("change_to_new_speed", _change_to_new_speed)

func _physics_process(delta) -> void:
	position.y += note_speed

func _input(event) -> void:
	if event.is_action_pressed(key) and is_on_button:
		queue_free()

# changes how fast the notes will come down, allowing for adjustable tempos
func _change_to_new_speed(speed: int) -> void:
	note_speed = speed

func _on_area_2d_area_entered(area) -> void:
	if area.is_in_group("miss"):
		is_on_button = true

func _on_area_2d_area_exited(area):
	if area.is_in_group("miss"):
		is_on_button = false
