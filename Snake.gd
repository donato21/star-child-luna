extends Node2D

export var awake_sound: AudioStream
export var sleep_sound: AudioStream
export(float, -80, 24, 0.1) var volume_db = 0

signal game_over

var sleeping = true
var min_sleep_time: float = 3
var max_sleep_time: float = 6
var min_wake_time: float = 2
var max_wake_time: float = 4

func _ready():
	$Timer.set_wait_time(rand_range(min_sleep_time, max_sleep_time))
	$Timer.start()

func _on_SleepTimer_timeout():
	if sleeping:
		$Timer.set_wait_time(rand_range(min_wake_time, max_wake_time))
		$Area2D/DeathCircle.visible = true
		$Timer.start()
		if awake_sound != null:
			$AudioStreamPlayer2D.set_stream(awake_sound)
			$AudioStreamPlayer2D.play()
		$AnimatedSprite.play("awake")
		for body in $Area2D.get_overlapping_bodies():
			if body.name == "Player":
				kill_player()
		sleeping = false
	else:
		$Timer.set_wait_time(rand_range(min_sleep_time, max_sleep_time))
		$Area2D/DeathCircle.visible = false
		$Timer.start()
		if sleep_sound != null:
			$AudioStreamPlayer2D.set_stream(sleep_sound)
			$AudioStreamPlayer2D.play()
		$AnimatedSprite.play("asleep")
		sleeping = true

func _on_Area2D_body_entered(body):
	if body.name == "Player" && !sleeping:
		kill_player()

func kill_player():
	get_parent().emit_signal("game_over","snake")
