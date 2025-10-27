extends Button

@onready var sfx_hover: AudioStreamPlayer = $"../SFX Hover"
@onready var sfx_click: AudioStreamPlayer = $"../SFX Click"
@onready var sfx_success: AudioStreamPlayer = $"../SFX Success"
@onready var sfx_failure: AudioStreamPlayer = $"../SFX Failure"
@onready var win_screen: Control = $"../WinScreen"
@onready var picreg_capthca = get_node("..")
#@onready var picreg_capthca = $PictureRegCaptcha
var captcha_name


func _on_mouse_entered():
	sfx_hover.play()
	captcha_name = get_parent()
	print(captcha_name.name)

func _on_pressed():
	sfx_click.play()
	if captcha_name.name == "DragCaptcha":
		if Global.valid_Nums <= 0:
			Global.captcha_cleared = true
			sfx_success.play()
			print("all clear")
			Engine.time_scale = 0
			#win_screen.show()
		else:
			print("not done")
			sfx_failure.play()
			
	elif captcha_name.name == "PictureRegCaptcha":
		if picreg_capthca.valid_PicReg_Nums <= 0 && picreg_capthca.invalid_PicReg_Nums <= 0:
			picreg_capthca.picRegCaptcha_cleared = true
			sfx_success.play()
			print("all clear")
			Engine.time_scale = 0
		else:
			print("not done")
			sfx_failure.play()
	
