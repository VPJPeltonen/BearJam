extends Camera

export var camera_speed = 1.0

onready var target = get_parent().get_node("Snek/CameraPos")
onready var tracker = get_parent().get_node("PlayerTracker")
#onready var carts = get_tree().get_nodes_in_group("Cart")

func _process(delta):
	#if !GAME.race_on:
		#return
	global_transform.origin = global_transform.origin.linear_interpolate(target.global_transform.origin, camera_speed*delta)#target.global_transform.origin
	look_at(tracker.global_transform.origin,Vector3.UP)
	#if carts.empty():
	#	return
	#for cart in carts:
	#	if cart == null:
	#		return
	#	var cart_forward = cart.forward_vector
	#	var view_vector = global_transform.origin - cart.global_transform.origin
	#	view_vector = view_vector.normalized()
	#	cart_forward = cart_forward.normalized()
	#	var dot = view_vector.dot(cart_forward)
	#	var rot_dot = view_vector.x*-cart_forward.z + view_vector.z*cart_forward.x
	#	if(rot_dot > 0):
	#		if dot > 0.5:
	#			cart.set_sprite_view("forward")
	#		elif dot > 0.2:
	#			cart.set_sprite_view("left")
	#		else:
	#			cart.set_sprite_view("side_left")
	#	elif(rot_dot < 0):		
	#		if dot > 0.5:
	#			cart.set_sprite_view("forward")
	#		elif dot > 0.2:
	#			cart.set_sprite_view("right")
	#		else:
	#			cart.set_sprite_view("side_right")
	#	else:
	#		cart.set_sprite_view("forward")
