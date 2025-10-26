class_name Stopwatch
extends Node

@onready var lose_screen: Control = $"../LoseScreen"

var time = 11.0
var stopped = true

func _process(delta):
	if stopped == false:
		time = time - .015
		#print("Time:",time)
	if time <= 0:
		Engine.time_scale = 0
		stopped = true
		lose_screen.show()

#func reset():
	#time = 11.0

func time_to_string() -> String:
	#make the time var a string to use in UI
	var sec = fmod(time, 60)
	var min = time / 60
	#just formating the timer
	var format_string = "%02d : %02d"
	var actual_string = format_string % [min, sec]
	return actual_string
