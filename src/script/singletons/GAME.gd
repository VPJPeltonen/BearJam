extends Node

var grid_size = 2
var beat_speed = 0.6

func reset():
	grid_size = 2
	beat_speed = 0.8

func go_faster():
	beat_speed = beat_speed * 0.9

func go_slower():
	beat_speed = beat_speed * 1.11
