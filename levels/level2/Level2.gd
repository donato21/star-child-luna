extends Node2D

export var level_theme_path: String = ""
export var left_level_path: String = ""
export var right_level_path: String = ""

signal load_scene
signal play_audio
signal game_over
signal dialog
signal add_inv

func _ready():
	emit_signal("play_audio", {"path":level_theme_path, "type":"loop"})

