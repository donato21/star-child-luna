extends KinematicBody2D

signal player_dead
signal area_entered
signal item_equiped

export var speed : int = 50
export var gravity : float = 5
var dir : Vector2 = Vector2.ZERO
var vel : Vector2 = Vector2.ZERO

func _ready():
	$AnimatedSprite.play("idleB")

func _input(_event):
	dir = Vector2.ZERO
	if Input.is_action_pressed("left"):
		dir.x -= 1
		$AnimatedSprite.scale = Vector2(-1,1)
	if Input.is_action_pressed("right"):
		dir.x += 1
		$AnimatedSprite.scale = Vector2(1,1)

func _process(_delta):
	if not is_on_floor():
		dir.y += gravity
	if dir.x != 0:
		$AnimatedSprite.play("walkR")
	else:
		$AnimatedSprite.play("idleB")
	vel = move_and_slide(speed * dir,Vector2.UP)
