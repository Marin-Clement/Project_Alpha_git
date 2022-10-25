extends Node

onready var items = {
	"stone_brick" : preload( "res://items/data/stone_brick.tscn" ),
}

func get_item( id : String ):
	return items[ id ].instance()
