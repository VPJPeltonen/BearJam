extends Position3D

var track_speed = 1.0

onready var snek = get_parent().get_node("Snek")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.origin = global_transform.origin.linear_interpolate(snek.global_transform.origin, track_speed*delta)#target.global_transform.origin
