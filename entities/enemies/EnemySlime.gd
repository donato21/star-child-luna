extends KinematicBody2D

export var party : String
export(int, "Left", "Right", "Forward", "Back") var starting_face
export var base_damage : int = 1
export var inv : Array = []

export var speed : int = 50
var dir : Vector2 = Vector2.ZERO
var vel : Vector2 = Vector2.ZERO

var facing : Vector2 = Vector2.ZERO

func _ready():
	if starting_face == 0:
		$AnimatedSprite.play("idleL")
		facing = Vector2.LEFT
	if starting_face == 1:
		$AnimatedSprite.play("idleR")
		facing = Vector2.RIGHT
	if starting_face == 2:
		$AnimatedSprite.play("idleF")
		facing = Vector2.UP
	if starting_face == 3:
		$AnimatedSprite.play("idleB")
		facing = Vector2.DOWN

func _process(delta):
	if vel.x < 0:
		$AnimatedSprite.play("walkL")
		facing = Vector2.LEFT
	if vel.x > 0:
		$AnimatedSprite.play("walkR")
		facing = Vector2.RIGHT
	if vel.y < 0:
		$AnimatedSprite.play("walkF")
		facing = Vector2.UP
	if vel.y > 0:
		$AnimatedSprite.play("walkB")
		facing = Vector2.DOWN
	if vel == Vector2.ZERO:
		if facing == Vector2.LEFT:
			$AnimatedSprite.play("idleL")
		if facing == Vector2.RIGHT:
			$AnimatedSprite.play("idleR")
		if facing == Vector2.UP:
			$AnimatedSprite.play("idleF")
		if facing == Vector2.DOWN:
			$AnimatedSprite.play("idleB")
