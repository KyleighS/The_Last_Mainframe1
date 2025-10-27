extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var captcha: Node2D = $PictureRegCaptcha
@onready var stopwatch = $PictureRegCaptcha/Stopwatch

func _process(delta: float):
	if captcha.picRegCaptcha_cleared == true:
		queue_free()
		Engine.time_scale = 1

func _ready() -> void:
	interactable.interact = on_interact
	

func on_interact():
	#stopwatch.stopped = false
	#print("State: ", stopwatch.stopped)
	captcha.show()
	Engine.time_scale = 0
