extends Node2D

export var sleep_time: float = 2
export var min_wake_time: float = 1
export var max_wake_time: float = 3
export var awake_sound_path: String = ""
export var sleep_sound_path: String = ""

var sleeping = true



func _on_SleepTimer_timeout():
	if sleeping:
		$Timer.set_wait_time(rand_range(min_wake_time, max_wake_time))
		
