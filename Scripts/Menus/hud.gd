class_name HUD
extends Control

@export var stopwatch_label : Label
var stopwatch : Stopwatch

# Called when the node enters the scene tree for the first time.
func _ready():
	stopwatch = get_tree().get_first_node_in_group("stopwatch")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float):
	#update_stopwatch_label()

#func update_stopwatch_label():
	#stopwatch_label.text = stopwatch.time_to_string()
