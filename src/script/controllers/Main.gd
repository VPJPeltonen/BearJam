extends Spatial

export(PackedScene) var test_map

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func restart():
	GAME.reset()
	var children = get_children()
	for child in children:
		child.queue_free()
	var new_map = test_map.instance()
	add_child(new_map)
	new_map.connect("restart", self, "_on_TestMap_restart")

func _on_TestMap_restart():
	restart()
