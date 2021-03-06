extends KinematicBody

signal died
signal win(score)

export(PackedScene) var tail_segment

var dir = Vector3(0,0,-1)
var current_rot = 0
var directions = [Vector3(0,0,1),Vector3(-1,0,0),Vector3(0,0,-1),Vector3(1,0,0)]
var mesh_dirs = [Vector3(0,0,0),Vector3(0,270,0),Vector3(0,180,0),Vector3(0,90,0)]

var frozen = false
var mode = "Cheese"
var tail

var score = 0

var speed_prepared = false
var jump_prepared = false
var break_prepared = false

var jump_cooldown = 0

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
				if jump_cooldown <= 0:
					jump_prepared = true
					jump_cooldown = 2
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
		"Rat":
			mode = "Red"
			add_tail()
			GAME.go_faster()
		"Frog":
			mode = "Green"
			add_tail()
			GAME.go_faster()
		"Beetle":
			mode = "Blue"
			add_tail()
			GAME.go_faster()
		_:
			pass

func add_tail():
	score += 1
	if tail == null:
		tail = tail_segment.instance()
		get_parent().add_child(tail)
		tail.init(self)
		print("trying")
	else:
		tail.add_tail()

func lose_tail():
	score -= 1
	$Hurt.play()
	if tail == null:
		print("DIEEE")
		frozen = true
		emit_signal("died")
	else:
		tail.damage()
		GAME.go_slower()

func horizontal_movement():
	if $Area.get_overlapping_bodies().size() == 0 :
		move_and_collide(Vector3(0,-1,0)*GAME.grid_size)
	if jump_prepared:
		$Jump.play()
		jump_prepared = false
		move_and_collide(Vector3(0,1,0)*GAME.grid_size)
		
func move():
	$Move.play()
	var previous_pos = global_transform.origin
	var collission
	if speed_prepared:
		$Dash.play()
		collission = move_and_collide(dir*GAME.grid_size*2)
		speed_prepared = false
	else:
		collission = move_and_collide(dir*GAME.grid_size)
	#round the vector coordinates to stop driftings
	global_transform.origin = Vector3(round(global_transform.origin.x),round(global_transform.origin.y),round(global_transform.origin.z))
	if collission != null:
		if collission.collider.is_in_group("Finish"):
			frozen = true
			emit_signal("win",score)
			return
		if collission.collider.is_in_group("Breakable") and mode == "Blue":
			collission.collider.queue_free()
			$Break.play()
			return
		if collission.collider.is_in_group("Door"):
			if collission.collider.color == mode:
				collission.collider.queue_free()
				$Unlock.play()
				return
		$Collide.play()
		global_transform.origin = previous_pos
		lose_tail()
	elif tail != null:
		tail.move(previous_pos,current_rot)
		
		
func _on_Beat_timeout():
	if frozen:
		return
	jump_cooldown -= 1
	horizontal_movement()
	move()
