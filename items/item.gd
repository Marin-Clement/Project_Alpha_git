class_name Item extends TextureRect

export( String ) var id
export( String ) var item_name
export( int ) var stack_size
export( int ) var quantity setget set_quantity

func _ready():
	set_quantity( quantity )

func pick_item():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func put_item():
	mouse_filter = Control.MOUSE_FILTER_PASS

func set_quantity( value ):
	quantity = value
	
	if $lbl_quantity:
		$lbl_quantity.text = str( quantity )
		$lbl_quantity.visible = quantity > 1

func add_item_quantity( value ):
	var remainder = quantity + value - stack_size
	quantity = min( quantity + value, stack_size)
	set_quantity( quantity )
	return remainder
