extends Node2D

var is_on_button: bool = false

func _physics_process(delta) -> void:
	position.y += 1

func _input(event) -> void:
	if event.is_action_pressed("j-key") and is_on_button:
		queue_free()

func _on_area_2d_area_entered(area) -> void:
	is_on_button = true

func _on_area_2d_area_exited(area) -> void:
	is_on_button = false
