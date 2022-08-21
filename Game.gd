extends Node2D

export var main_menu_path : String
export var level_0_path : String

signal scene_loaded

func _ready():
	$CanvasLayer/Black.visible = true
	$CanvasLayer/Black/ColorRect.set_modulate(Color(255,255,255,255))
	for child in $SceneManager.get_children():
		child.queue_free()
	var scene = load(main_menu_path).instance()
	$SceneManager.add_child(scene)
	scene.connect("load_scene", self, "load_and_add_scene")
	scene.connect("play_audio", self, "track_manager")
	scene.connect("game_over", self, "game_over")
	scene.connect("dialog", self, "dialog")
	$CanvasLayer/Animations.play("fade_in")
	yield($CanvasLayer/Animations,"animation_finished")
	$CanvasLayer/Black.visible = false

func load_and_add_scene(path : String):
	if path != "":
		$CanvasLayer/Black.visible = true
		$CanvasLayer/Animations.play("fade_out")
		yield($CanvasLayer/Animations,"animation_finished")
		for child in $SceneManager.get_children():
			child.queue_free()
		var scene = load(path).instance()
		$SceneManager.add_child(scene)
		scene.connect("load_scene", self, "load_and_add_scene")
		scene.connect("play_audio", self, "track_manager")
		scene.connect("game_over", self, "game_over")
		scene.connect("dialog", self, "dialog")
		$CanvasLayer/Animations.play("fade_in")
		yield($CanvasLayer/Animations,"animation_finished")
		$CanvasLayer/Black.visible = false
		emit_signal("scene_loaded")
	else:
		print("Game.gd|load_and_add_scene()|ERROR: path empty!")

func track_manager(track : Dictionary):
	if track.path != "":
		# Check priority of track
		if track.type == "loop":
			$AudioManager/BGMusic.set_stream(track.path)
			$AudioManager/BGMusic.play()
		if track.type == "instant":
			if !$AudioManager/Instant1.playing():
				$AudioManager/Instant1.set_stream(track.path)
				$AudioManager/Instant1.play()
			else:
				$AudioManager/Instant2.set_stream(track.path)
				$AudioManager/Instant2.play()
	else:
		print("Game.gd|track_manager()|ERROR: track path empty!")

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

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
	dialog("What a terrible dream...")

func snake_death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	dialog("I think I should be more careful...")

func queen_death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	dialog("Maybe if I hide behind the reeds?")

func frog_death():
	load_and_add_scene(level_0_path)
	yield(self,"scene_loaded")
	$Timer.start()
	yield($Timer,"timeout")
	dialog("This will be tough!")
