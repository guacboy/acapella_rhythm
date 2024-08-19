extends Node2D

@onready var stage_crowd_lt_1 = $Crowd/StageCrowdLt1
@onready var stage_crowd_rt_1 = $Crowd/StageCrowdRt1
@onready var stage_crowd_lt_2 = $Crowd/StageCrowdLt2
@onready var stage_crowd_rt_2 = $Crowd/StageCrowdRt2
@onready var stage_crowd_lt_3 = $Crowd/StageCrowdLt3
@onready var stage_crowd_rt_3 = $Crowd/StageCrowdRt3
@onready var stage_crowd_lt_4 = $Crowd/StageCrowdLt4
@onready var stage_crowd_rt_4 = $Crowd/StageCrowdRt4
@onready var stage_crowd_lt_5 = $Crowd/StageCrowdLt5
@onready var stage_crowd_rt_5 = $Crowd/StageCrowdRt5
@onready var despawn_zone = $DespawnZone

var max_lives: float = 10.0
var initial_positions = {}

func _ready() -> void:
	Signals.connect("on_life_change", _on_life_change)
	
	initial_positions = {
		"lt2": stage_crowd_lt_2.position,
		"rt2": stage_crowd_rt_2.position,
		"lt3": stage_crowd_lt_3.position,
		"rt3": stage_crowd_rt_3.position,
		"lt4": stage_crowd_lt_4.position,
		"rt4": stage_crowd_rt_4.position,
		"lt5": stage_crowd_lt_5.position,
		"rt5": stage_crowd_rt_5.position,
	}

func _process(delta) -> void:
	if max_lives <= 0.0:
		Signals.emit_signal("set_speed", 1)
		despawn_zone.scale.y = 80.0
		
		var tween := create_tween().set_parallel()
		tween.tween_property(stage_crowd_lt_1, "position:x", stage_crowd_lt_1.position.x - 500, 0.3)
		tween.tween_property(stage_crowd_rt_1, "position:x", stage_crowd_rt_1.position.x + 500, 0.3)
		tween.tween_property(Engine, "time_scale", 0.0, 1.0)
		tween.tween_property(AudioServer, "playback_speed_scale", 0.0, 0.5)
		tween.finished.connect(
			func () -> void:
				Engine.time_scale = 1.0
				AudioServer.playback_speed_scale = 1.0
				get_tree().reload_current_scene()
		)
	
	# shifts crowd out of frame - indicating lost of life
	var tween := create_tween().set_parallel()
	if max_lives <= 8.0:
		tween.tween_property(stage_crowd_lt_5, "position:x", stage_crowd_lt_5.position.x - 100, 0.5)
		tween.tween_property(stage_crowd_rt_5, "position:x", stage_crowd_rt_5.position.x + 100, 0.5)
	if max_lives <= 6.0:
		tween.tween_property(stage_crowd_lt_4, "position:x", stage_crowd_lt_4.position.x - 200, 0.5)
		tween.tween_property(stage_crowd_rt_4, "position:x", stage_crowd_rt_4.position.x + 200, 0.5)
	if max_lives <= 4.0:
		tween.tween_property(stage_crowd_lt_3, "position:x", stage_crowd_lt_3.position.x - 300, 0.5)
		tween.tween_property(stage_crowd_rt_3, "position:x", stage_crowd_rt_3.position.x + 300, 0.5)
	if max_lives <= 2.0:
		tween.tween_property(stage_crowd_lt_2, "position:x", stage_crowd_lt_2.position.x - 400, 0.5)
		tween.tween_property(stage_crowd_rt_2, "position:x", stage_crowd_rt_2.position.x + 400, 0.5)
	
	# shifts crowd into frame - indicating gain of life
	tween = create_tween().set_parallel()
	if max_lives >= 8.0:
		tween.tween_property(stage_crowd_lt_5, "position:x", initial_positions["lt5"].x, 0.5)
		tween.tween_property(stage_crowd_rt_5, "position:x", initial_positions["rt5"].x, 0.5)
	if max_lives >= 6.0:
		tween.tween_property(stage_crowd_lt_4, "position:x", initial_positions["lt4"].x, 0.5)
		tween.tween_property(stage_crowd_rt_4, "position:x", initial_positions["rt4"].x, 0.5)
	if max_lives >= 4.0:
		tween.tween_property(stage_crowd_lt_3, "position:x", initial_positions["lt3"].x, 0.5)
		tween.tween_property(stage_crowd_rt_3, "position:x", initial_positions["rt3"].x, 0.5)
	if max_lives >= 2.0:
		tween.tween_property(stage_crowd_lt_2, "position:x", initial_positions["lt2"].x, 0.5)
		tween.tween_property(stage_crowd_rt_2, "position:x", initial_positions["rt2"].x, 0.5)

func _on_life_change(life: float) -> void:
	max_lives = clamp(max_lives + life, 0.0, 10.0)
