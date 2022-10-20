extends KinematicBody2D
export (int) var speed = 400
var acc = 1
var realspeed
onready var target = position
var velocity = Vector2()
func _input(event):
	if event.is_action_pressed("left_mouse"):
		target = get_global_mouse_position()
		acc = 0
		print(get_tree().get_root().print_tree())

func _physics_process(delta):
	acc += 0.01
	if acc > 1:
		acc = 1
	realspeed = speed * acc
	_move_to_target()
	print(PlayerVariables.playerpos)

func _move_to_target():
	velocity = position.direction_to(target) * realspeed
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
