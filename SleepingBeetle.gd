extends Node2D

export var sleeping_sound_path: String = ""
export(String, "loop", "instant") var sleeping_sound_type = "instant"

var player

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body
		if not body.cloaked:
			$CollisionShape2D.disabled = false
			$AnimatedSprite.play("awake")
			$AnimationPlayer.stop()
			var line = ""
			if "cape" in body.inv:
				line = "Lunara: I need to be hidden [X]"
			else:
				var lines = ["Lunara: I can't go any further...","Lunara: Useless beetle. I guess I’ll have to search somewhere else.", "Lunara: If only I had my cape."]
				line = lines[round(rand_range(-0.2,lines.size()-0.8))]
			get_parent().emit_signal("dialog",line)
		else:
			$CollisionShape2D.disabled = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$AnimatedSprite.play("asleep")
		$AnimationPlayer.play()

func _input(_event):
	if player != null:
		if Input.is_action_just_pressed("cape") and player.cloaked:
			$CollisionShape2D.disabled = true
