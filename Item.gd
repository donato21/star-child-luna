extends Node2D

export var title: String = "item"
export var image: Texture
export var dialog: Array = []

var pick_up = false
var player

func _ready():
	$Sprite.set_texture(image)

func _input(_event):
	if Input.is_action_pressed("interact") && pick_up:
		get_parent().emit_signal("add_inv",title)
		player.inv.append(title)
		get_parent().emit_signal("dialog",dialog)
		queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body
		get_parent().emit_signal("dialog","[Press E to Pick Up]")
		pick_up = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		pick_up = false
