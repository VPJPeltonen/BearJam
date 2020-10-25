extends Spatial

export(PackedScene) var test_map
export(PackedScene) var final_map

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func restart():
	GAME.reset()
	$Node2D.show()
	var children = $Map.get_children()
	for child in children:
		child.queue_free()
	var new_map = final_map.instance()
	$Map.add_child(new_map)
	new_map.connect("restart", self, "_on_TestMap_restart")

func _on_TestMap_restart():
	restart()

func _on_StartButton_pressed():
	$Node2D.hide()
	var map = $Map.get_children()[0]
	map.start_game()


func _on_ExitButton_pressed():
	pass # Replace with function body.


func _on_CreditsButton_pressed():
	pass # Replace with function body.


func _on_ControlsButton_pressed():
	pass # Replace with function body.


func _on_TestMap2_restart():
	pass # Replace with function body.
