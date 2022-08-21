extends Node2D

export var primary_audio : AudioStream
export var secondary_audio : AudioStream
export var left_level_path: String = ""
export var right_level_path: String = ""

signal load_scene
signal game_over
signal dialog
signal add_inv

func _ready():
	var list = ["Moon","Luna","Beetle","Sun","Snake","Frog","Wings","Cape","Ring","Shield","Sleep","Awake","Flower","Blossom","Mountain","Reed","Vine","Cave","Water","Lake","Mirror","Waterfall","Wane","Wax","Crescent","Full","Sky","Flying Frog","Donate","Gale","Mark","Element"]
	randomize()
	var word = list[round(rand_range(0, list.size() - 1))]
	$CanvasLayer/Secret.set_text(word)
