extends Area2D

signal give_object_stats

var stats = {
	"name": "Rock",
	"health": 10
}

func _on_Object_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			GameManager.lastobjectclicked = stats
			print(GameManager.lastobjectclicked)
