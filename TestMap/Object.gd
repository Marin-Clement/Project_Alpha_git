extends Area2D

var objecttype = "harvestable"
var objectname
var health
var timetoharvest
var amount

var over = preload("res://TestMap/Sprite/OverSprite.png")
var working = preload("res://TestMap/Sprite/WorkingSprite.png")

func _ready():
	$OverSprite.visible = false

func _on_Object_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			GameManager.lastobjectclicked = self

func _on_Object_mouse_entered():
	$OverSprite.visible = true
	$OverSprite.set_texture(over)
	
func _on_Object_mouse_exited():
	$OverSprite.visible = false

func _has_Been_Harvest():
	GameManager.lastobjectclicked = null
	queue_free()

func _been_Harvest():
	$OverSprite.visible = true
	$OverSprite.set_texture(working)
	
func _cancel_targeted():
	$OverSprite.visible = false


