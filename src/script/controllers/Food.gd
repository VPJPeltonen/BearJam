extends Area

export var type = "Cheese"
export var move_range = 3
export var dir = Vector3(0,0,1)

var angry = false
var angry_cooldown = 5
#var current_rot = 0
var directions = [Vector3(0,0,1),Vector3(-1,0,0),Vector3(0,0,-1),Vector3(1,0,0)]
var in_air = false

onready var moves_left = move_range
onready var current_rot = directions.find(dir)

func on_beat():
	angry_cooldown -= 1
	if angry_cooldown <= 0:
		angry = !angry
		angry_cooldown = 5
	$AnimatedSprite3D.forward = -dir
	match type:
		"Frog":
			horizontal_movement()
			move(1)
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

func horizontal_movement():
	if !in_air:
		in_air = true
		global_transform.origin += Vector3(0,1,0)*GAME.grid_size
		moves_left += 1
	else:
		global_transform.origin += Vector3(0,-1,0)*GAME.grid_size
		in_air = false
		
func _on_Food_body_entered(body):
	if body.is_in_group("Snake"):
		if angry:
			body.lose_tail()
		else:
			body.food_eaten(type)
			queue_free()
