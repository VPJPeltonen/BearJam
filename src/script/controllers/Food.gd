extends Area

export var type = "Cheese"
export var move_range = 4
export var dir = Vector3(0,0,1)

var angry = false

onready var moves_left = move_range

func on_beat():
	$AnimatedSprite3D.forward = -dir
	match type:
		"Frog":
			move()
		"Beetle":
			move()
		"Rat":
			move()

func move():
	var previous_pos = global_transform.origin
	global_transform.origin += dir*GAME.grid_size
	#round the vector coordinates to stop driftings
	global_transform.origin = Vector3(round(global_transform.origin.x),round(global_transform.origin.y),round(global_transform.origin.z))
	moves_left -= 1
	if moves_left <= 0:
		moves_left = move_range
		dir = -dir

func _on_Food_body_entered(body):
	if body.is_in_group("Snake"):
		if angry:
			pass
		else:
			body.food_eaten(type)
			queue_free()
