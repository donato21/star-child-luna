extends Node2D

export var title: String = "item"
export var image: Texture

var pick_up = false

func _ready():
	$Sprite.set_texture(image)

func _input(_event):
	if Input.is_action_pressed("interact") && pick_up:
		get_parent().emit_signal("add_inv",title)
		get_parent().emit_signal("dialog",
			["[Press X to use the dark side of the moon and hide your presence]",
				"Lunara: I could use this to get past the sleeping beetle"])
		queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_parent().emit_signal("dialog","[Press E to Pick Up]")
		pick_up = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		pick_up = false
