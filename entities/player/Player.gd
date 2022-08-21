extends KinematicBody2D

export var walk_sound_path: String = ""
export(String, "loop", "instant") var walk_sound_type = "instant"
export var sprite_x_scale: int = 1

var speed : int = 100
var gravity : int = 100
var max_speed: int = 700
var max_gravity: int = 3000
var fall_timer : float = 0.05

var dir : Vector2 = Vector2.ZERO
var vel : Vector2 = Vector2.ZERO

var flying = false
var inv = []

func _ready():
	$AnimatedSprite.scale.x = sprite_x_scale
	$AnimatedSprite.play("idle")

func _physics_process(_delta):
	dir = Vector2.ZERO
	dir.y = 1
	if Input.is_action_pressed("left"):
		dir.x = -1
		$AnimatedSprite.scale = Vector2(1,1)
	if Input.is_action_pressed("right"):
		dir.x = 1
		$AnimatedSprite.scale = Vector2(-1,1)
	if flying:
		pass
	else:
		if ($RayCast2D.is_colliding() || is_on_floor()) && abs(vel.x) > 50:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
	if is_on_floor() and dir.x == 0:
		if vel.length() < 99:
			vel = Vector2.ZERO
		vel = lerp(vel,Vector2.ZERO,0.3)
	else:
		vel += Vector2(dir.x * speed, dir.y * gravity)
	vel = Vector2(clamp(vel.x,(-1 * max_speed), max_speed), clamp(vel.y,(-1 * max_gravity), max_gravity))
	vel = move_and_slide(vel, Vector2.UP, true)
