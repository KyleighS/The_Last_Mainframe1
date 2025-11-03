extends Node2D

@export var valid_Drag_Nums = 3
@export var valid_PicReg_Nums = 5
@export var invalid_PicReg_Nums = 0
@export var picRegCaptcha_cleared = false
@export var dragCaptcha_cleared = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
