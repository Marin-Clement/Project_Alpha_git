extends NinePatchRect

export( NodePath ) onready var inventory = get_node( inventory ) as Inventory

var open = true


func _ready():
	rect_size.y = 20 + inventory.rect_size.y
	


	
func _on_close_pressed():
	hide()


func _input(event):
	if event.is_action_pressed("inventory"):
		if open == true:
			hide()
			open = false
		elif open == false:
			show()
			open = true



func _on_Drone_giveplayeritem(itemid):
	$inventory_container/inventory.add_item( ItemManager.get_item( itemid ) )
