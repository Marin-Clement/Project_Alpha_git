extends KinematicBody2D

export (int) var speed = (500)
var acc = 1
var realspeed
onready var target = position
var velocity = Vector2.ZERO
var working = false
var d = 0
var radius = 100.0
onready var player = get_node("/root/TestMap/Player")
var idle = false
var harvest = false
var targetEnemy = false
var fire_rate = 0.3
var can_fire = true
signal giveplayeritem( itemid )

func _input(event):
	if event.is_action_pressed("left_mouse"):
		yield(_Wait(0.05),"completed")
		acc = 0
		if(GameManager.lastobjectclicked != null):
			target = GameManager.lastobjectclicked.position
			working = true
		if(GameManager.lastobjectclicked != null):
			if(GameManager.lastobjectclicked.objecttype == "enemy"): 
				GameManager.enemyTarget = true
		idle = false
		
	if event.is_action_pressed("right_mouse") and GameManager.lastobjectclicked != null:
		GameManager.lastobjectclicked._cancel_targeted()
		working = false
		GameManager.enemyTarget = false
		yield(_Wait(0.01),"completed")
		GameManager.lastobjectclicked = null

func _physics_process(delta):
	d += delta
	realspeed = speed * acc
	# Follow player
	if working == false and idle == false:
		if position.distance_to(player.position) > 85:
			_follow_player(delta)
			look_at(get_global_mouse_position())
		elif(position.distance_to(player.position)) <= 86:
			idle = true
	# Give an order
	elif working == true:
		# Check if its an harvestable
		if(GameManager.lastobjectclicked != null):
			if(GameManager.lastobjectclicked.objecttype == "harvestable" ):
				_move_to_target()
				_Rotate_Around(GameManager.lastobjectclicked)
				look_at(GameManager.lastobjectclicked.position)
				GameManager.lastobjectclicked._been_Harvest()
				if(harvest == false and position.distance_to(GameManager.lastobjectclicked.position) <= 101):
					harvest = true
					_harvest(GameManager.lastobjectclicked)
			#Check if its an enemy
			if(GameManager.lastobjectclicked.objecttype == "enemy"):
				if(GameManager.enemyTarget == true):
					_target_Enemy(GameManager.lastobjectclicked, delta)
					if can_fire:
						can_fire = false
						_shoot(GameManager.lastobjectclicked)
						yield(_Wait(fire_rate),"completed")
						can_fire = true
				else:
					working = false
					targetEnemy = false
	# Idle position
	if(idle == true):
		_Rotate_Around(player)
		look_at(get_global_mouse_position())
		if position.distance_to(player.position) > 150 or player.velocity != Vector2.ZERO:
			idle = false
	_acc()

func _move_to_target():
	velocity = position.direction_to(target) * realspeed
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
	if position.distance_to(target) < 100:
		velocity = Vector2.ZERO

func _acc():
	acc += 0.01
	if acc > 1:
		acc = 1

func _follow_player(delta):
	position += (player.position - position)/50

func _Wait(s):
	var t = Timer.new()
	t.set_wait_time(s)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()

func _Rotate_Around(object):
	target = Vector2(sin(d) * radius,cos(d) * radius) + object.position
	velocity = position.direction_to(target) * 100
	velocity = move_and_slide(velocity)

func _harvest(objectToHarvest):
	print("harvesting...")
	yield(_Wait(objectToHarvest.timetoharvest),"completed")
	if objectToHarvest != GameManager.lastobjectclicked or null:
		print("cancel harvest")
		objectToHarvest._cancel_targeted()
		harvest = false
	else:
		objectToHarvest._has_Been_Harvest()
		print("finish harvesting")
		emit_signal("giveplayeritem", "stone_brick")
		print("+ ",objectToHarvest.amount," ",objectToHarvest.objectname)
		working = false
		harvest = false
	
func _target_Enemy(enemyToTarget, delta):
	look_at(enemyToTarget.position)
	position += (player.position - Vector2(position.x + 100,position.y + 100))/20
	enemyToTarget._been_targeted()
	
func _shoot(enemyToShoot):
	var bullet = preload("res://Drone/Bullet.tscn").instance()
	bullet.set_as_toplevel(true)
	bullet.rotation_degrees = rotation_degrees
	bullet.global_position = $muzzle.global_position
	$muzzle.add_child(bullet)
