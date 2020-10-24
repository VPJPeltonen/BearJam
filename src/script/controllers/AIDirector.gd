extends Spatial

func _on_Beat_timeout():
	$Timer.start()

func _on_Timer_timeout():
	get_tree().call_group("AI", "on_beat")
