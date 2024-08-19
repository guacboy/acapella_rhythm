extends Node2D

@onready var despawn_zone = $DespawnZone

var max_lives: float = 10.0

func _ready() -> void:
	Signals.connect("on_life_change", _on_life_change)

func _process(delta) -> void:
	if max_lives <= 0.0:
		Signals.emit_signal("set_speed", 1)
		despawn_zone.scale.y = 80.0
		
		var tween := create_tween().set_parallel()
		tween.tween_property(Engine, "time_scale", 0.0, 1.0)
		tween.tween_property(AudioServer, "playback_speed_scale", 0.0, 0.5)
		tween.finished.connect(
			func () -> void:
				Engine.time_scale = 1.0
				AudioServer.playback_speed_scale = 1.0
				get_tree().reload_current_scene()
		)

func _on_life_change(life: float) -> void:
	max_lives += life
	
	if max_lives > 10.0:
		max_lives = 10.0
