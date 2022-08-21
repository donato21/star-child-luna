extends Node2D

export var sleeping_sound_path: String = ""
export(String, "loop", "instant") var sleeping_sound_type = "instant"



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if not body.cloaked:
			$CollisionShape2D.set_visible(true)
			$AnimatedSprite.play("awake")
			$AnimationPlayer.stop()
			var lines = ["I can't go any further...","Useless beetle. I guess I’ll have to search somewhere else.", "If only I had my cape."]
			get_parent().emit_signal("dialog",lines[round(rand_range(-0.2,lines.size()+0.2))])
		else:
			$CollisionShape2D.set_visible(false)


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$AnimatedSprite.play("asleep")
		$AnimationPlayer.play()
