extends Spatial

signal restart

func start_game():
	$Beat.start()

func _on_LoseScreen_reset():
	emit_signal("restart")

func _on_WinSceen_reset():
	emit_signal("restart")

