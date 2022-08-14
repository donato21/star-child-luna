extends Node2D

signal load_scene

func _on_Play_pressed():
	emit_signal("load_scene", "res://levels/Level1.tscn")
