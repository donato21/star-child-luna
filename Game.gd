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
	for child in get_children():
		child.queue_free()
	var scene = load(path).instance()
	add_child(scene)
	scene.connect("load_scene", self, "load_and_add_scene")

func save_enemies(enemies_array : Array):
	enemies = enemies_array

func load_enemies():
	for enemy in enemies:
		var new_enemy = load(enemy.path).instance()
