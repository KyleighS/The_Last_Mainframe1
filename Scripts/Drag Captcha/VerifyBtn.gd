extends Button

@onready var sfx_hover: AudioStreamPlayer = $"../SFX Hover"
@onready var sfx_click: AudioStreamPlayer = $"../SFX Click"
@onready var sfx_success: AudioStreamPlayer = $"../SFX Success"
@onready var sfx_failure: AudioStreamPlayer = $"../SFX Failure"
@onready var win_screen: Control = $"../WinScreen"
@onready var drag_stopwatch: Node2D = $DragCaptcha/Stopwatch
@onready var picReg_stopwatch: Node2D = $PictureRegCaptcha/Stopwatch
@onready var picreg_capthca = get_node("..")
@onready var num_captcha = get_node("..")
@onready var num_stopwatch: Node2D = $NumCaptcha/Stopwatch
#@onready var picreg_capthca = $PictureRegCaptcha
var captcha_name
var verified

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_mouse_entered():
	sfx_hover.play()
	captcha_name = get_parent()
	print(captcha_name.name)

func _on_pressed():
	sfx_click.play()
	if captcha_name.name == "DragCaptcha":
		if Global.valid_Nums <= 0:
			Global.captcha_cleared = true
			#drag_stopwatch.reset()
			sfx_success.play()
			print("all clear")
			get_tree().paused = false
			#win_screen.show()
		else:
			print("not done")
			sfx_failure.play()
			
	elif captcha_name.name == "PictureRegCaptcha":
		if picreg_capthca.valid_PicReg_Nums <= 0 && picreg_capthca.invalid_PicReg_Nums <= 0:
			picreg_capthca.picRegCaptcha_cleared = true
			#picReg_stopwatch.reset()
			sfx_success.play()
			print("all clear")
			get_tree().paused = false
		else:
			print("not done")
			sfx_failure.play()
	
	elif captcha_name.name == "NumCaptcha":
		print("checked")
		if num_captcha.captcha_cleared:
			verified = true
			sfx_success.play()
			print("all clear")
			get_tree().paused = false
			win_screen.show()
