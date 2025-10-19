class_name Stopwatch
extends Node

@onready var lose_screen: Control = $"../LoseScreen"

var time = 11.0
var stopped = false

func _process(delta):
	if stopped:
		return
	time -= delta
	if time <= 0:
		Engine.time_scale = 0
		lose_screen.show()

func reset():
	time = 10.0

func time_to_string() -> String:
	#make the time var a string to use in UI
	var sec = fmod(time, 60)
	var min = time / 60
	#just formating the timer
	var format_string = "%02d : %02d"
	var actual_string = format_string % [min, sec]
	return actual_string
