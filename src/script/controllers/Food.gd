extends Area

export var type = "Cheese"
export var move_range = 3
export var dir = Vector3(0,0,1)

var angry = false
#var current_rot = 0
var directions = [Vector3(0,0,1),Vector3(-1,0,0),Vector3(0,0,-1),Vector3(1,0,0)]

onready var moves_left = move_range
onready var current_rot = directions.find(dir)

func on_beat():
	$AnimatedSprite3D.forward = -dir
	match type:
		"Frog":
			move(2)
			if moves_left <= 0:
				moves_left = move_range
				dir = -dir
		"Beetle":
			move(1)
			if moves_left <= 0:
				moves_left = move_range
				dir = -dir
		"Rat":
			move(1)
			if moves_left <= 0:
				current_rot += 1
				if current_rot > directions.size()-1:
					current_rot = 0
				elif current_rot < 0:
					current_rot = directions.size()-1
				moves_left = move_range
				dir = directions[current_rot]

func move(amount):
	var previous_pos = global_transform.origin
	global_transform.origin += dir*GAME.grid_size*amount
	#round the vector coordinates to stop driftings
	global_transform.origin = Vector3(round(global_transform.origin.x),round(global_transform.origin.y),round(global_transform.origin.z))
	moves_left -= 1


func _on_Food_body_entered(body):
	if body.is_in_group("Snake"):
		if angry:
			pass
		else:
			body.food_eaten(type)
			queue_free()
