extends Node


func _ready():
	_create_object(400,750,"rock",10,2,5)
	_create_object(600,500,"rock",12,5,20)
	
func _create_object(positionx,positiony,name,hp,time,oamount):
	var object = preload("res://TestMap/Object.tscn").instance()
	
	object.position.x = positionx
	object.position.y = positiony
	object.objectname = name
	object.health = 10
	object.timetoharvest = time
	object.amount = oamount
	add_child(object)
