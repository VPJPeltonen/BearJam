extends Spatial

signal restart

func _on_LoseScreen_reset():
	emit_signal("restart")
