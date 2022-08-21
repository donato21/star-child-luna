extends Node2D

export var primary_audio : AudioStream
export var secondary_audio : AudioStream
export var left_level_path : String = ""
export var right_level_path : String = ""

signal load_scene
signal game_over
signal dialog
signal add_inv

func _on_LeftLevelArea_body_entered(body):
	if body == $Player:
		emit_signal("load_scene", left_level_path)
		print("Level 2 loading...")

func _on_RightLevelArea_body_entered(body):
	if body == $Player:
		emit_signal("load_scene", right_level_path)
		print("Level 1 loading...")
