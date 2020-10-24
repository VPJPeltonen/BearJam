extends Area

export var type = "Cheese"

func _on_Food_body_entered(body):
	if body.is_in_group("Snake"):
		body.food_eaten(type)
		queue_free()
