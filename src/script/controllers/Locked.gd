extends StaticBody

export var color = "Red"

func _ready():
	pass
	#set_up()

func _open():
	$door/AnimationPlayer.play("Door Open")	

func set_up():
	match color:
		"Red":
			$Red.show()
			$Blue.hide()
			$Green.hide()
		"Blue":
			$Red.hide()
			$Blue.show()
			$Green.hide()
		"Green":
			$Red.hide()
			$Blue.hide()
			$Green.show()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
