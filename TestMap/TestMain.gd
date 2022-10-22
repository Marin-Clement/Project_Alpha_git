extends Node


func _ready():
	_create_object(400,750,"Rock",10)
	_create_object(600,750,"Rock",12)

	
func _create_object(positionx,positiony,name,hp):
	var object = preload("res://TestMap/Object.tscn").instance()
	
	object.position.x = positionx
	object.position.y = positiony
	object.stats = {"name": name, "health": hp}
	add_child(object)
