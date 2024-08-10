extends Node2D

@onready var cpu_particles_2d = $CPUParticles2D

func _ready() -> void:
	cpu_particles_2d.emitting = true
	cpu_particles_2d.finished.connect(queue_free)
