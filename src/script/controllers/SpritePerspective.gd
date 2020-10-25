extends AnimatedSprite3D

var forward = Vector3(0,0,1)

func play_animation(type):
	var string = type
	if get_parent().in_air:
		string = "jump_" + string
	if get_parent().angry:
		string = "angry_" + string
	play(string)
