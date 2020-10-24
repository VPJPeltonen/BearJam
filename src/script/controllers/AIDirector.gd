extends Spatial

func _on_Beat_timeout():
	get_tree().call_group("AI", "on_beat")
