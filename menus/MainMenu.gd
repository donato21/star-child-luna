extends Node2D

export var primary_audio: AudioStream
export var on_play_scene_path: String = "res://levels/Level1.tscn"

signal load_scene

func _on_Play_pressed():
	emit_signal("load_scene", on_play_scene_path)

func _on_Quit_pressed():
	get_parent().get_tree().quit()

func _on_Options_pressed():
	$CanvasLayer/OptionsPopUp.play("show")
	$CanvasLayer/PopUpTimer.start()

func _on_PopUpTimer_timeout():
	$CanvasLayer/OptionsPopUp.play("hide")
