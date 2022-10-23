extends Area2D

var speed = 10
var damage = 10

func _process(delta):
	position += (transform.x*speed)


func _on_Bullet_body_entered(body):
	if !body.is_in_group("enemy"):
		queue_free()

func _on_Bullet_area_entered(area):
	if area.is_in_group("enemy"):
		area._take_Damage(damage)
		queue_free()
