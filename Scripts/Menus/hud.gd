class_name HUD
extends Control

@export var stopwatch_label : Label
#var stopwatch : Stopwatch
@onready var stopwatch: Stopwatch = $"../Stopwatch"

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	#stopwatch = get_tree().get_first_node_in_group("stopwatch")
	#stopwatch = get_tree().get_first_node_in_group("stopwatch")
	stopwatch.time_updated.connect(update_stopwatch_label)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float):
	#update_stopwatch_label()

func update_stopwatch_label(new_time):
	#print(stopwatch.time_to_string())
	#print(new_time)
	stopwatch_label.text = new_time
	#stopwatch_label.text = stopwatch.time_to_string()
