extends Node2D

signal load_scene
signal play_audio

export var level_theme_path : String = ""
export var left_level_path : String = ""
export var right_level_path : String = ""

func _ready():
	emit_signal("play_audio", {"path": level_theme_path, "type":"loop"})

func _on_LeftLevelArea_body_entered(body):
	if body == $Player:
		emit_signal("load_scene", left_level_path)
		print("Level 2 loading...")

func _on_RightLevelArea_body_entered(body):
	if body == $Player:
		emit_signal("load_scene", right_level_path)
		print("Level 1 loading...")
