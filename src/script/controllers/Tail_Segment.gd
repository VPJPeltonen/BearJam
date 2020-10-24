extends KinematicBody

export(PackedScene) var tail_segment

var dir = Vector3(0,0,1)
var current_rot = 0
var mesh_dirs = [Vector3(0,0,0),Vector3(0,90,0),Vector3(0,180,0),Vector3(0,270,0)]

var tail

func init(host):
	global_transform.origin = host.get_tail_spawn_pos()

func move(pos,previous_dir):
	var old_dir = current_rot
	current_rot = previous_dir
	rotation_degrees = mesh_dirs[current_rot]
	var old_pos = global_transform.origin
	global_transform.origin = pos
	if tail != null:
		tail.move(old_pos,old_dir)

func get_tail_spawn_pos():
	return global_transform.origin-(dir*GAME.grid_size)

func add_tail():
	if tail == null:
		tail = duplicate()
		tail.tail = null
		get_parent().add_child(tail)
		tail.init(self)
		#tail._init(self)
	else:
		tail.add_tail()
