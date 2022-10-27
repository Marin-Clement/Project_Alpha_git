extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func _ready():
	pass
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("sprint"):
		speed = 300
		$AnimatedSprite.speed_scale = 2
	if Input.is_action_just_released("sprint"):
		speed = 200
		$AnimatedSprite.speed_scale = 1
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	if velocity.x >= 1 and velocity.y == 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.playing = true
	if velocity.x <= 1 and velocity.y == 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.playing = true
	if velocity.x >= 1 and velocity.y == 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.playing = true
	if velocity.x <= 1 and velocity.y == 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.playing = true
	if velocity.x == 0 and velocity.y <= 1:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.playing = true
	if velocity.x == 0 and velocity.y >= 1:
		$AnimatedSprite.animation = "down"
		$AnimatedSprite.playing = true
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite.animation = "down"
		$AnimatedSprite.playing = true
