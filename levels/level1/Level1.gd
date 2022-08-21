extends Node2D

export var primary_audio : AudioStream
export var secondary_audio : AudioStream
export var left_level_path: String = ""

signal load_scene
signal game_over
signal dialog
signal add_inv

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("load_scene",left_level_path)
