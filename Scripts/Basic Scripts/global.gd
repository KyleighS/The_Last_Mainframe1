extends Node

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


#vars for drag captcha
var is_dragging = false
var captcha_cleared = false
var valid_Nums = 3
