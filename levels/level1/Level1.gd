extends Node2D

export var level_theme_path: String = ""
export var left_level_path: String = ""

signal load_scene
signal play_audio
signal game_over

func _ready():
	emit_signal("play_audio", {"path":level_theme_path, "type":"loop"})
	$Snake.connect("game_over", self, "game_over")

func game_over(death):
	emit_signal("game_over",death)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		emit_signal("load_scene",left_level_path)
