extends Node2D

export var min_sleep_time: float = 3
export var max_sleep_time: float = 6
export var min_wake_time: float = 2
export var max_wake_time: float = 4
export var deay: float = 0
export var awake_sound_path: String = ""
export var sleep_sound_path: String = ""

var sleeping = true

func _on_SleepTimer_timeout():
	if sleeping:
		$Timer.set_wait_time(rand_range(min_wake_time, max_wake_time))
		$DeathCircle.visible = true
		$Timer.start()
		$AnimatedSprite.play("awake")
		for body in $Area2D.get_overlapping_bodies():
			if body.name == "Player":
				kill_player()
		sleeping = false
	else:
		$Timer.set_wait_time(rand_range(min_sleep_time, max_sleep_time))
		$DeathCircle.visible = false
		$Timer.start()
		$AnimatedSprite.play("asleep")
		sleeping = true

func _on_Area2D_body_entered(body):
	if body.name == "Player" && !sleeping:
		kill_player()

func kill_player():
	print("player should be dead...")
