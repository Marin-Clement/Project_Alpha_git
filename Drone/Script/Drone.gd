extends KinematicBody2D

export (int) var speed = 1000
var acc = 1
var realspeed
onready var target = position
var velocity = Vector2.ZERO
var working = false
var d = 0

func _input(event):
	if event.is_action_pressed("left_mouse"):
		acc = 0
		target = get_global_mouse_position()
		working = true	

func _physics_process(delta):
	var player = get_node("/root/TestMap/Player")
	realspeed = speed * acc
	if working == false:
		if position.distance_to(player.position) > 85:
			_follow_player()
	elif working == true:
		_move_to_target()
	_acc()


func _move_to_target():
	velocity = position.direction_to(target) * realspeed
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
	if position.distance_to(target) < 50:
		yield(_Wait(1),"completed")
		velocity = Vector2.ZERO
		working = false

func _acc():
	acc += 0.01
	if acc > 1:
		acc = 1

func _follow_player():
	var player = get_node("/root/TestMap/Player")
	position += (player.position - position)/50
	
func _Wait(s):
	var t = Timer.new()
	t.set_wait_time(s)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
