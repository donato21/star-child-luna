extends Node2D

var timer : Timer

signal load_scene

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "hidePopUp")
	timer.set_one_shot(true)
	timer.set_wait_time(1.0)
	add_child(timer)

func _on_Play_pressed():
	emit_signal("load_scene", "res://levels/Level1.tscn")


func _on_Quit_pressed():
	get_parent().get_tree().quit()


func _on_Options_pressed():
	$CanvasLayer/OptionsPopUp.play("show")
	timer.start()

func hidePopUp():
	$CanvasLayer/OptionsPopUp.play("hide")
