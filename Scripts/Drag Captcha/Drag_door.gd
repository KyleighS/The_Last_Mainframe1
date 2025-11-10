extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var captcha: Node2D = $DragCaptcha
@onready var stopwatch = $DragCaptcha/Stopwatch

@export var valid_Nums = 3
@export var captcha_cleared = false

func _process(delta: float):
	if Global.captcha_cleared:
		queue_free()
		get_tree().paused = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	interactable.interact = on_interact
	
	

func on_interact():
	stopwatch.stopped = false
	stopwatch.reset()
	#print("State: ", stopwatch.stopped)
	captcha.show()
	get_tree().paused = true
