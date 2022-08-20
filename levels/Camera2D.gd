extends Camera2D

export(NodePath) onready var top_left = get_node(top_left) as Position2D
export(NodePath) onready var bottom_right = get_node(bottom_right) as Position2D
export(NodePath) onready var player = get_node(player) as KinematicBody2D

var bounds = {"top":"", "right":"", "bottom":"", "left":""}

func _ready():
	bounds.top = top_left.get_global_position().y
	bounds.left = top_left.get_global_position().x
	bounds.bottom = bottom_right.get_global_position().y
	bounds.right = bottom_right.get_global_position().x
	set_limit(MARGIN_TOP, bounds.top)
	set_limit(MARGIN_RIGHT, bounds.right)
	set_limit(MARGIN_BOTTOM, bounds.bottom)
	set_limit(MARGIN_LEFT, bounds.left)

#func _process(_delta):
#	position = lerp(position, player.position, 0.1)

func _physics_process(_delta):
	position = lerp(position, player.position, 0.1)
