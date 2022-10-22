extends Area2D

var objecttype = "enemy"
var enemyname = "skeleton"
var health = 100

var over = preload("res://Enemy_Test/Sprites/OverSprite.png")
var working = preload("res://TestMap/Sprite/WorkingSprite.png")
signal enemydead

func _ready():
	$OverSprite.visible = false

	

func _on_Enemy_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			GameManager.lastobjectclicked = self
			print("New Enemy target : ", GameManager.lastobjectclicked.enemyname)

func _on_Enemy_mouse_entered():
	$OverSprite.visible = true
	$OverSprite.set_texture(over)


func _on_Enemy_mouse_exited():
	$OverSprite.visible = false

func _been_targeted():
	$OverSprite.visible = true
	$OverSprite.set_texture(working)
	
func _cancel_targeted():
	$OverSprite.visible = false

func _take_Damage(damage):
	health -= damage

func _physics_process(delta):
	if health <= 0:
		$AnimatedSprite.animation = "Death"
		$OverSprite.visible = false
		GameManager.enemyTarget = false
		yield(get_tree().create_timer(0.1),"timeout")
		GameManager.lastobjectclicked = null
		yield(get_tree().create_timer(0.2),"timeout")
		queue_free()

func _on_Detect_zone_body_entered(body):
		if body.is_in_group("player"):
			$OverSprite.visible = true
			$OverSprite.set_texture(over)


func _on_Detect_zone_body_exited(body):
		if body.is_in_group("player"):
			$OverSprite.visible = false


