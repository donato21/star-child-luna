extends KinematicBody2D

signal player_dead
signal area_entered
signal item_equiped

var speed : int = 600
var gravity : int = 500
var fall_timer : float = 0.05

var dir : Vector2 = Vector2.ZERO
var vel : Vector2 = Vector2.ZERO

func _ready():
	$AnimatedSprite.play("idleB")

func _physics_process(_delta):
	dir = Vector2.ZERO
	if Input.is_action_pressed("left"):
		dir.x = -1
		$AnimatedSprite.scale = Vector2(1,1)
	if Input.is_action_pressed("right"):
		dir.x = 1
		$AnimatedSprite.scale = Vector2(-1,1)
	
	if ($RayCast2D.is_colliding() || is_on_floor()) && abs(vel.x) > 10:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	
	if not is_on_floor():
		dir.y = 1
	else:
		dir.y = 0
	vel.x = dir.x * speed
	vel.y = dir.y * gravity
	vel = vel.clamped(speed)
	vel = move_and_slide(vel, Vector2.UP)
