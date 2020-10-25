extends Spatial

signal restart

func start_game():
	$Beat.start()

func _on_LoseScreen_reset():
	emit_signal("restart")
