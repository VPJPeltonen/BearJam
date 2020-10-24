extends StaticBody

export var color = "Red"

func _ready():
	set_up()
	
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
