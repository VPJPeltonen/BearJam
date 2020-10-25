extends AnimatedSprite3D

var forward = Vector3(0,0,1)

func play_animation(type):
	if !get_parent().in_air:
		play(type)
	else:
		play("jump_"+type)
