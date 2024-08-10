extends Node2D

func _ready() -> void:
	self.emitting = true
	self.finished.connect(queue_free)
