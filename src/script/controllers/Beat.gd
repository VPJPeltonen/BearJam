extends Timer


func _on_Beat_timeout():
	start(GAME.beat_speed)
