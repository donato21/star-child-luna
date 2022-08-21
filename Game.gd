extends Node2D

export var main_menu_path : String
export var level_0_path : String

signal scene_loaded

var player_inv: Array = []
var items: Array = ["cape","ring","wings","shield"]

var volume = {"PrimaryBG":0.0,"Secondary":0.0}
var audio_fade_in_length = 3

func _ready():
	volume.PrimaryBG = $AudioManager/PrimaryBG.get_volume_db()
	volume.Secondary = $AudioManager/Secondary.get_volume_db()
	$AudioManager/PrimaryBG.set_volume_db(-80)
	$AudioManager/Secondary.set_volume_db(-80)
	
	$CanvasLayer/Black.visible = true
	$CanvasLayer/Black/ColorRect.set_modulate(Color(255,255,255,255))
	for child in $SceneManager.get_children():
		child.queue_free()
	var scene = load(main_menu_path).instance()
	$SceneManager.add_child(scene)
	scene.connect("load_scene", self, "load_and_add_scene")
	$CanvasLayer/Animations.play("fade_in")
	if "primary_audio" in scene:
		audio_manager(scene.primary_audio, "primary")
	if "secondary_audio" in scene:
		audio_manager(scene.secondary_audio, "secondary")
	yield($CanvasLayer/Animations,"animation_finished")
	yield($AudioManager/Tween,"tween_all_completed")
	$CanvasLayer/Black.visible = false

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func load_and_add_scene(path : String):
	if path != "":
		$CanvasLayer/Black.visible = true
		$CanvasLayer/Animations.play("fade_out")
		fade_out($AudioManager/PrimaryBG)
		fade_out($AudioManager/Secondary)
		yield($CanvasLayer/Animations,"animation_finished")
		yield($AudioManager/Tween,"tween_all_completed")
		for child in $SceneManager.get_children():
			child.queue_free()
		var scene = load(path).instance()
		$SceneManager.add_child(scene)
		scene.connect("load_scene", self, "load_and_add_scene")
		scene.connect("game_over", self, "game_over")
		scene.connect("dialog", self, "dialog")
		scene.connect("add_inv", self, "add_to_inventory")
		if scene.get_node("Player") != null:
			scene.get_node("Player").inv = player_inv
		$CanvasLayer/Animations.play("fade_in")
		if "primary_audio" in scene:
			audio_manager(scene.primary_audio, "primary")
		if "secondary_audio" in scene:
			audio_manager(scene.secondary_audio, "secondary")
		yield($CanvasLayer/Animations,"animation_finished")
		yield($AudioManager/Tween,"tween_all_completed")
		$CanvasLayer/Black.visible = false
		emit_signal("scene_loaded")
	else:
		print("Game.gd|load_and_add_scene()|ERROR: path empty!")

func audio_manager(audio: AudioStream,track: String):
	if audio != null:
		if track == "primary":
			$AudioManager/PrimaryBG.set_stream(audio)
			fade_in($AudioManager/PrimaryBG)
		elif track == "secondary":
			$AudioManager/Secondary.set_stream(audio)
			fade_in($AudioManager/Secondary)
		else:
			print("game.gd|audio|Error: not valid track")
	else:
		print("game.gd|audio|Error: Not valid audiostream")

func fade_out(stream_player: AudioStreamPlayer):
	print("fade_out called")
	# tween music volume down to 0
	$AudioManager/Tween.interpolate_property(stream_player, "volume_db", 
		stream_player.get_volume_db(), -80, 2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	$AudioManager/Tween.start()
	yield($AudioManager/Tween,"tween_completed")
	stream_player.stop()

func fade_in(stream_player: AudioStreamPlayer):
	print("fade_in called")
	# tween music volume up from -80
	var target_vol = 0.0
	if stream_player.name == volume.keys()[0]:
		target_vol = volume.PrimaryBG
	else:
		target_vol = volume.Secondary
	$AudioManager/Tween.interpolate_property(stream_player, "volume_db", 
		-40, target_vol, audio_fade_in_length, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	$AudioManager/Tween.start()
	stream_player.play()

func dialog(text):
	$CanvasLayer/Text.visible = true
	if text is Array:
		for line in text:
			$CanvasLayer/Text/ColorRect/Label.set_text(line)
			yield($CanvasLayer/Text/ColorRect/Button, "pressed")
	if text is String:
		$CanvasLayer/Text/ColorRect/Label.set_text(text)
		yield($CanvasLayer/Text/ColorRect/Button, "pressed")
	$CanvasLayer/Text.visible = false
	$CanvasLayer/Text/ColorRect/Label.set_text("")

func add_to_inventory(item: String):
	if item in items:
		player_inv.append(item)
		if item == "cape":
			add_cape()
		if item == "ring":
			add_ring()
		if item == "wings":
			add_wings()
		if item == "shield":
			add_shield()
	else:
		print("Game:add_to_inventory: Item invalid")

func add_cape():
	print("Cape added to inventory")

func add_ring():
	print("Ring added to inventory")

func add_wings():
	print("Wings added to inventory")

func add_shield():
	print("Shield added to inventory")

func game_over(death):
	if death == "snake":
		snake_death()
	elif death == "queen_beetle":
		queen_death()
	elif death == "flying_frog":
		frog_death()
	else:
		death()

func death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	dialog(["[You feel well-rested]","Lunara: What a terrible dream..."])

func snake_death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	dialog(["[You feel well-rested]","Lunara: I think I should be more careful..."])

func queen_death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	var lines = ["I cannot attack her head on.","What a strong creature.","I need to stay back...","How can I avoid the attacks?","I know I can do this!","There must be a better way..."]
	dialog(["[You feel well-rested]",lines[round(rand_range(-0.2,lines.size()-0.8))]])

func frog_death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	dialog(["[You feel well-rested]","Lunara: I can't give up now, I'm almost done..."])
