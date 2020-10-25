extends Control

signal reset()

func _on_Button_pressed():
	emit_signal("reset")

func _on_Snek_died():
	show()

func _on_Snek_win(score):
	show()
	$Score.text = "Your Score: " + str(score)
