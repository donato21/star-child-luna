extends Node2D

export var title: String = "item"
export var image: Texture
export var dialog: Array = []
export var pick_up_audio: AudioStream
export(float, -80, 24, 0.1) var volume_db = 0

var pick_up = false
var player

func _ready():
	$Sprite.set_texture(image)
	$AudioStreamPlayer2D.set_volume_db(volume_db)
	if pick_up_audio != null:
		$AudioStreamPlayer2D.set_stream(pick_up_audio)

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
