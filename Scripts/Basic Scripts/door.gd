extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var drag_captcha: Node2D = $DragCaptcha

@export var valid_Nums = 3
@export var captcha_cleared = false

func _process(delta: float):
	if Global.captcha_cleared:
		queue_free()
		Engine.time_scale = 1

func _ready() -> void:
	interactable.interact = on_interact

func on_interact():
	drag_captcha.show()
	Engine.time_scale = 0
