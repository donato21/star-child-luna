extends Node2D

export var intro_animation_path : String
export var main_menu_path : String
export var level_1_path : String
export var invis_death_path : String
export var combat_death_path : String
export var win_path : String

var enemies : Array = []
var player_inv : Array = []

func _ready():
	load_and_add_scene(main_menu_path)

func load_and_add_scene(path : String):
	if path != "":
		for child in $SceneManager.get_children():
			child.queue_free()
		var scene = load(path).instance()
		$SceneManager.add_child(scene)
		scene.connect("load_scene", self, "load_and_add_scene")
		scene.connect("play_audio", self, "track_manager")
	else:
		print("Game.gd|load_and_add_scene()|ERROR: path empty!")

func save_enemies(enemies_array : Array):
	enemies = enemies_array

func load_enemies():
	for enemy in enemies:
		var new_enemy = load(enemy.path).instance()

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
