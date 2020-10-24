extends Spatial

var dir = Vector3(0,0,1)
var current_rot = 0
var directions = [Vector3(0,0,1),Vector3(-1,0,0),Vector3(0,0,-1),Vector3(1,0,0)]
var mesh_dirs = [Vector3(0,0,0),Vector3(0,90,0),Vector3(0,180,0),Vector3(0,270,0)]

func _process(delta):
	if Input.is_action_just_pressed("turn_left"):
		change_rot(-1)
	elif Input.is_action_just_pressed("turn_right"):
		change_rot(1)
		

func change_rot(amount):
	current_rot += amount
	if current_rot > directions.size()-1:
		current_rot = 0
	elif current_rot < 0:
		current_rot = directions.size()-1
	rotation_degrees = mesh_dirs[current_rot]
	dir = directions[current_rot]
		
func _on_Beat_timeout():
	global_transform.origin += dir*GAME.grid_size
