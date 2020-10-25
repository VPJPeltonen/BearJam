extends AnimatedSprite3D

var forward = Vector3(0,0,1)

func play_animation(type):
	if get_parent().in_air:
		type = "jump_" + type
	if get_parent().angry:
		type = "angry_" + type
	play(type)
