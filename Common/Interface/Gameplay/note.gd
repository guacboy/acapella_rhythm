extends Node2D

@export var key: String = ""

@onready var body = $Body

var is_in_miss_area: bool = false
var is_exactly_on_button: bool = false
var is_out_of_bounds: bool = false
var note_speed: int = 0

func _ready() -> void:
	Signals.connect("change_to_new_speed", _change_to_new_speed)

func _physics_process(delta) -> void:
	position.y += note_speed
	
	if is_out_of_bounds:
		fade_out(body)

func _input(event) -> void:
	# if note is exactly over the button, delete the note
	if event.is_action_pressed(key) and is_exactly_on_button:
		queue_free()
	
	# if note is in the miss area, fade out the note and disables the button
	if event.is_action_pressed(key) and is_in_miss_area:
		body.modulate.a = 0.25

# changes how fast the notes will come down, allowing for adjustable tempos
func _change_to_new_speed(speed: int) -> void:
	note_speed = speed
	
# fades out the note if out of bounds
func fade_out(object: Sprite2D) -> void:
	var tween := create_tween()
	tween.tween_property(object, "modulate:a", 0.0, 0.3)
	tween.finished.connect(queue_free)

func _on_body_area_area_entered(area):
	if area.is_in_group("miss"):
		is_in_miss_area = true
	if area.is_in_group("okay"):
		is_exactly_on_button = true
	if area.is_in_group("despawn"):
		is_out_of_bounds = true

func _on_body_area_area_exited(area):
	if area.is_in_group("miss"):
		is_in_miss_area = false
	if area.is_in_group("okay"):
		is_exactly_on_button = false
