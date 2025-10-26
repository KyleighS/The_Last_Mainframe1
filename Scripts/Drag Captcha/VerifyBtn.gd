extends Button

@onready var sfx_hover: AudioStreamPlayer = $"../SFX Hover"
@onready var sfx_click: AudioStreamPlayer = $"../SFX Click"
@onready var sfx_success: AudioStreamPlayer = $"../SFX Success"
@onready var sfx_failure: AudioStreamPlayer = $"../SFX Failure"
@onready var win_screen: Control = $"../WinScreen"
var Door = preload("res://Scenes/BasicGame/door.tscn").get_script()
var captcha_manager

func ready():
	captcha_manager.get_parent().get_script()

func _on_mouse_entered():
	sfx_hover.play()

func _on_pressed():
	sfx_click.play()
	if Global.valid_Nums <= 0:
		Global.captcha_cleared = true
		sfx_success.play()
		#print("all clear")
		Engine.time_scale = 0
		#win_screen.show()
	else:
		#print("not done")
		sfx_failure.play()
	
