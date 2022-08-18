extends Node2D

signal load_scene

func _on_Level2_body_entered(body):
	if body == $Player:
		emit_signal("load_scene", "")
		print("Level 2 loading...")


func _on_Level3_body_entered(body):
	if body == $Player:
		emit_signal("load_scene", "")
		print("Level 3 loading...")
