extends Node2D

@export var key: String = ""

@onready var body = $Body
@onready var body_area = $BodyArea
@onready var line = $Line
@onready var line_area = $LineArea

var is_on_button: bool = false # within "miss" range
var is_exactly_on_button: bool = false # within "okay" range
var is_key_held_down: bool = false
var is_out_of_bounds: bool = false
var note_speed: int = 0

func _ready() -> void:
	Signals.connect("change_to_new_speed", _change_to_new_speed)

func _physics_process(delta) -> void:
	position.y += note_speed
	
	# shrinks the line as the key is being pressed
	if is_key_held_down and line.scale.x >= 0.0:
		shorten_line()
	if is_key_held_down and not is_exactly_on_button and line.scale.x >= 0.0:
		shorten_line()
	if is_out_of_bounds and not is_key_held_down and line.scale.x >= 0.0:
		shorten_line()
		fade_out(body)
		fade_out(line)

func _input(event) -> void:
	# if miss, disables the line
	if event.is_action_pressed(key) and is_on_button and not is_exactly_on_button:
		body_area.queue_free()
		line_area.queue_free()
		fade_out(body)
		fade_out(line)
	
	# gets rid of the note head
	if event.is_action_pressed(key) and is_exactly_on_button:
		is_key_held_down = true
		fade_out(line)
		body.queue_free()
		body_area.queue_free()
		
	# breaks combo and disables the line
	if event.is_action_released(key) and is_exactly_on_button:
		is_key_held_down = false
		Signals.emit_signal("on_combo_increment", false)
		key = ""

# changes how fast the notes will come down, allowing for adjustable tempos
func _change_to_new_speed(speed: int) -> void:
	note_speed = speed
	
# shortens the line sprite
func shorten_line() -> void:
	line.scale.x -= 0.2
	line.position.y -= 1.55

# fades out the note if out of bounds
func fade_out(object: Sprite2D) -> void:
	object.modulate.a = 0.25
	
	var tween := create_tween()
	tween.tween_property(object, "modulate:a", 0.0, 0.3)
	tween.finished.connect(queue_free)

func _on_body_area_area_entered(area):
	if area.is_in_group("miss"):
		is_on_button = true
	if area.is_in_group("despawn"):
		is_out_of_bounds = true

func _on_body_area_area_exited(area):
	if area.is_in_group("miss"):
		is_on_button = false

func _on_line_area_area_entered(area):
	if area.is_in_group("okay"):
		is_exactly_on_button = true

func _on_line_area_area_exited(area):
	if area.is_in_group("okay"):
		is_exactly_on_button = false



