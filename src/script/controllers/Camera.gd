extends Camera

export var camera_speed = 1.0

onready var target = get_parent().get_node("Snek/CameraPos")
onready var tracker = get_parent().get_node("PlayerTracker")
onready var sprites = get_tree().get_nodes_in_group("3dSprite")

func _process(delta):
	sprites = get_tree().get_nodes_in_group("3dSprite")
	global_transform.origin = global_transform.origin.linear_interpolate(target.global_transform.origin, camera_speed*delta)#target.global_transform.origin
	look_at(tracker.global_transform.origin,Vector3.UP)
	if sprites.empty():
		return
	for sprite in sprites:
		if sprite == null:
			return
		var sprite_forward = sprite.forward
		var view_vector = $Position3D.global_transform.origin - sprite.global_transform.origin
		view_vector = view_vector.normalized()
		sprite_forward = sprite_forward.normalized()
		var dot = view_vector.dot(sprite_forward)
		var rot_dot = view_vector.x*-sprite_forward.z + view_vector.z*sprite_forward.x
		if(rot_dot > 0):
			if dot > 0.5:
				sprite.play_animation("back")
			elif dot < -0.5:
				sprite.play_animation("front")
			else:
				sprite.play_animation("left")
		elif(rot_dot < 0):		
			if dot > 0.5:
				sprite.play_animation("back")
			elif dot < -0.5:
				sprite.play_animation("front")
			else:
				sprite.play_animation("right")
		else:
			sprite.play_animation("front")
