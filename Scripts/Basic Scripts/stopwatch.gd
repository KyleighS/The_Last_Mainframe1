extends Node
class_name Stopwatch

@onready var lose_screen: Control = $"../LoseScreen"

var start_time = 21.0
var time = 21.0
var stopped = true

signal time_updated(new_time)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if stopped == false:
		time -= delta
		emit_signal("time_updated", time_to_string())
		#print("Time:",time)
	if time <= 0:
		get_tree().paused = true
		stopped = true
		lose_screen.show()

func reset():
	time = start_time

func time_to_string() -> String:
	#make the time var a string to use in UI
	var sec = fmod(time, 60)
	var min = time / 60
	#just formating the timer
	var format_string = "%02d : %02d"
	var actual_string = format_string % [min, sec]
	return actual_string
