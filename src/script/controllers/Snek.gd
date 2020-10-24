extends KinematicBody

signal died

export(PackedScene) var tail_segment

var dir = Vector3(0,0,-1)
var current_rot = 0
var directions = [Vector3(0,0,1),Vector3(-1,0,0),Vector3(0,0,-1),Vector3(1,0,0)]
var mesh_dirs = [Vector3(0,0,0),Vector3(0,270,0),Vector3(0,180,0),Vector3(0,90,0)]

var frozen = false
var mode = "Cheese"
var tail

var speed_prepared = false
var jump_prepared = false
var break_prepared = false

func _ready():
	current_rot = directions.find(dir)
	rotation_degrees = mesh_dirs[current_rot]

func _process(delta):
	if frozen:
		return
	if Input.is_action_just_pressed("turn_left"):
		change_rot(-1)
	elif Input.is_action_just_pressed("turn_right"):
		change_rot(1)
	if Input.is_action_just_pressed("special"):
		match mode:
			"Red":
				speed_prepared = true
			"Green":
				jump_prepared = true
			"Blue":
				break_prepared = true

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
			mode = "Yellow"
			add_tail()
			GAME.go_faster()
			$Visuals/Red.hide()
			$Visuals/Blue.hide()
			$Visuals/Yellow.show()
			$Visuals/Green.hide()
		"Rat":
			mode = "Red"
			$Visuals/Red.show()
			$Visuals/Blue.hide()
			$Visuals/Yellow.hide()
			$Visuals/Green.hide()
			add_tail()
			GAME.go_faster()
		"Frog":
			mode = "Green"
			$Visuals/Red.hide()
			$Visuals/Blue.hide()
			$Visuals/Yellow.hide()
			$Visuals/Green.show()
			add_tail()
			GAME.go_faster()
		"Beetle":
			mode = "Blue"
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
		print("DIEEE")
		frozen = true
		emit_signal("died")
	else:
		tail.damage()
		GAME.go_slower()

func move():
	if $Area.get_overlapping_bodies().size() == 0 :
		move_and_collide(Vector3(0,-1,0)*GAME.grid_size)
	if jump_prepared:
		jump_prepared = false
		move_and_collide(Vector3(0,1,0)*GAME.grid_size)
	$Move.play()
	var previous_pos = global_transform.origin
	var collission
	if speed_prepared:
		collission = move_and_collide(dir*GAME.grid_size*2)
		speed_prepared = false
	else:
		collission = move_and_collide(dir*GAME.grid_size)
	#round the vector coordinates to stop driftings
	global_transform.origin = Vector3(round(global_transform.origin.x),round(global_transform.origin.y),round(global_transform.origin.z))
	if collission != null:
		if collission.collider.is_in_group("Dirt"):
			print("DIIRT")
		if collission.collider.is_in_group("Door"):
			if collission.collider.color == mode:
				collission.collider.queue_free()
				$Unlock.play()
				return
			#move()
		$Collide.play()
		global_transform.origin = previous_pos
		lose_tail()
	elif tail != null:
		tail.move(previous_pos,current_rot)

		
func _on_Beat_timeout():
	if frozen:
		return
	move()
