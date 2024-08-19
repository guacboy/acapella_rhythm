extends Node2D

@export var key: String = ""

@onready var body = $Body

var is_in_miss_area: bool = false
var is_exactly_on_button: bool = false
var note_speed: int = 0

func _ready() -> void:
	Signals.connect("set_speed", _set_speed)

func _physics_process(delta) -> void:
	position.y += note_speed

func _input(event) -> void:
	# if note is exactly over the button, delete the note
	if event.is_action_pressed(key) and is_exactly_on_button:
		queue_free()
	
	# if note is in the miss area, fade out the note and disables the button
	if event.is_action_pressed(key) and is_in_miss_area:
		body.modulate.a = 0.25

# changes how fast the notes will come down, allowing for adjustable tempos
func _set_speed(speed: int) -> void:
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
		Signals.emit_signal("on_combo_increment", false)
		Signals.emit_signal("on_life_change", -1.0)
		fade_out(body)

func _on_body_area_area_exited(area):
	if area.is_in_group("miss"):
		is_in_miss_area = false
	if area.is_in_group("okay"):
		is_exactly_on_button = false
