extends KinematicBody

export(PackedScene) var tail_segment

var dir = Vector3(0,0,1)
var current_rot = 0
var directions = [Vector3(0,0,1),Vector3(-1,0,0),Vector3(0,0,-1),Vector3(1,0,0)]
var mesh_dirs = [Vector3(0,0,0),Vector3(0,270,0),Vector3(0,180,0),Vector3(0,90,0)]

var tail

func _process(delta):
	if Input.is_action_just_pressed("turn_left"):
		change_rot(-1)
	elif Input.is_action_just_pressed("turn_right"):
		change_rot(1)

func get_tail_spawn_pos():
	return global_transform.origin-(dir*GAME.grid_size)

func change_rot(amount):
	current_rot += amount
	if current_rot > directions.size()-1:
		current_rot = 0
	elif current_rot < 0:
		current_rot = directions.size()-1
	rotation_degrees = mesh_dirs[current_rot]
	dir = directions[current_rot]

func food_eaten(type):
	match type:
		"Cheese":
			add_tail()
			GAME.go_faster()
		"Rat":
			$Visuals/Red.show()
			$Visuals/Blue.hide()
			$Visuals/Yellow.hide()
			$Visuals/Green.hide()
			add_tail()
			GAME.go_faster()
		"Frog":
			$Visuals/Red.hide()
			$Visuals/Blue.hide()
			$Visuals/Yellow.hide()
			$Visuals/Green.show()
			add_tail()
			GAME.go_faster()
		"Beetle":
			$Visuals/Red.hide()
			$Visuals/Blue.show()
			$Visuals/Yellow.hide()
			$Visuals/Green.hide()
			add_tail()
			GAME.go_faster()
		_:
			pass

func add_tail():
	if tail == null:
		tail = tail_segment.instance()
		get_parent().add_child(tail)
		tail.init(self)
		print("trying")
	else:
		tail.add_tail()

func lose_tail():
	if tail == null:
		print("DIE")
	else:
		tail.damage()

func _on_Beat_timeout():
	$Move.play()
	var previous_pos = global_transform.origin
	var collission = move_and_collide(dir*GAME.grid_size)
	#round the vector coordinates to stop driftings
	global_transform.origin = Vector3(round(global_transform.origin.x),round(global_transform.origin.y),round(global_transform.origin.z))
	if collission != null:
		if collission.collider.is_in_group("Dirt"):
			print("DIIRT")
		$Collide.play()
		global_transform.origin = previous_pos
		lose_tail()
	elif tail != null:
		tail.move(previous_pos,current_rot)
	#global_transform.origin += dir*GAME.grid_size
