extends KinematicBody2D

signal player_dead
signal area_entered
signal item_equiped

export var speed : int = 50
var dir : Vector2 = Vector2.ZERO
var vel : Vector2 = Vector2.ZERO
var facing : Vector2 = Vector2.ZERO

func _ready():
	$AnimatedSprite.play("idleB")

func _input(_event):
	dir = Vector2.ZERO
	if Input.is_action_pressed("left"):
		dir.x -= 1
		facing = Vector2.LEFT
	if Input.is_action_pressed("right"):
		dir.x += 1
		facing = Vector2.RIGHT
	if Input.is_action_pressed("forward"):
		dir.y -= 1
		facing = Vector2.UP
	if Input.is_action_pressed("back"):
		dir.y += 1
		facing = Vector2.DOWN

func _process(_delta):
	if facing == Vector2.LEFT:
		if vel.x < 0:
			$AnimatedSprite.play("walkL")
		if vel.x == 0:
			$AnimatedSprite.play("idleL")
	if facing == Vector2.RIGHT:
		if vel.x > 0:
			$AnimatedSprite.play("walkR")
		if vel.x == 0:
			$AnimatedSprite.play("idleR")
	
	if facing == Vector2.UP:
		if vel.y < 0:
			$AnimatedSprite.play("walkF")
		if vel.y == 0:
			$AnimatedSprite.play("idleF")
	if facing == Vector2.DOWN:
		if vel.y > 0:
			$AnimatedSprite.play("walkB")
		if vel.y == 0:
			$AnimatedSprite.play("idleB")
	
	vel = move_and_slide(speed * dir)
