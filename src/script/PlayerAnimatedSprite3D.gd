extends AnimatedSprite3D

var forward = Vector3(0,0,1)

func _process(delta):
	forward = -get_parent().dir

func play_animation(type):
	var string = type
	match get_parent().mode:
		"Blue":
			string = "blue_" + string
		"Green":
			string = "green_" + string
		"Red":
			string = "red_" + string
	play(string)
