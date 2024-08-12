extends Node2D

@export var key: String = ""

@onready var sprite_2d = $Sprite2D
@onready var body_area = $BodyArea
@onready var line = $Line

var is_on_button: bool = false # within "miss" range
var is_exactly_on_button: bool = false # within "okay" range
var is_key_held_down: bool = false
var note_speed: int = 0

func _ready() -> void:
	Signals.connect("change_to_new_speed", _change_to_new_speed)

func _physics_process(delta) -> void:
	position.y += note_speed
	
	if is_key_held_down and line.scale.x >= 0.0:
		line.scale.x -= 0.2
		line.position.y -= 1.0
	if is_key_held_down and not is_exactly_on_button and line.scale.x >= 0.0:
		line.scale.x -= 0.2
		line.position.y -= 1.0

func _input(event) -> void:
	if event.is_action_pressed(key) and is_on_button and not is_exactly_on_button:
		queue_free()
	
	# gets rid of the note head
	if event.is_action_pressed(key) and is_exactly_on_button:
		is_key_held_down = true
		line.modulate.a = 0.25
		sprite_2d.queue_free()
		body_area.queue_free()
	# breaks combo and disables the line
	if event.is_action_released(key) and is_exactly_on_button:
		is_key_held_down = false
		Signals.emit_signal("on_combo_increment", false)
		key = ""

# changes how fast the notes will come down, allowing for adjustable tempos
func _change_to_new_speed(speed: int) -> void:
	note_speed = speed

func _on_area_2d_area_entered(area) -> void:
	if area.is_in_group("miss"):
		is_on_button = true

func _on_area_2d_area_exited(area):
	if area.is_in_group("miss"):
		is_on_button = false

func _on_line_area_area_entered(area):
	if area.is_in_group("okay"):
		is_exactly_on_button = true

func _on_line_area_area_exited(area):
	if area.is_in_group("okay"):
		is_exactly_on_button = false
