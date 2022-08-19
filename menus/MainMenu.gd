extends Node2D

signal load_scene
signal play_audio

export var menu_theme_path: String
export var on_play_scene_path: String = "res://levels/Level1.tscn"

func _ready():
	emit_signal("play_audio", {"path": menu_theme_path, "type":"loop"})

func _on_Play_pressed():
	emit_signal("load_scene", on_play_scene_path)

func _on_Quit_pressed():
	get_parent().get_tree().quit()

func _on_Options_pressed():
	$CanvasLayer/OptionsPopUp.play("show")
	$CanvasLayer/PopUpTimer.start()

func _on_PopUpTimer_timeout():
	$CanvasLayer/OptionsPopUp.play("hide")
