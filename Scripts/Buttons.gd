extends Button

const Ones_normal = preload("res://Scenes/PictureCaptcha/OnesBTN.tres")
const Ones_clicked = preload("res://Scenes/PictureCaptcha/Ones_Clicked.tres")
const Twos_normal = preload("res://Scenes/PictureCaptcha/TwosBTN.tres")
const Twos_clicked = preload("res://Scenes/PictureCaptcha/Twos_Clicked.tres")
@onready var captcha = get_node("../..") # Adjust if needed
var clicked = false

#func _ready():
	#captcha = captcha.get_script()

func _on_pressed() -> void:
	if is_in_group("Ones") && !clicked:
			add_theme_stylebox_override("normal", Ones_clicked)
			clicked = true
			#print(captcha.name)
			captcha.valid_PicReg_Nums -= 1
			#print(captcha.valid_PicReg_Nums)
	elif is_in_group("Twos") && !clicked:
		add_theme_stylebox_override("normal", Twos_clicked)
		captcha.invalid_PicReg_Nums += 1
		clicked = true

#func _on_toggled(toggled_on: bool) -> void:
	#if !toggled_on:
		#if is_in_group("Ones"):
			#add_theme_stylebox_override("normal", Ones_clicked)
			#clicked = true
			#captcha.vaild_PicReg_Nums -= 1
			#print(captcha.vaild_PicReg_Nums)
			#if captcha.vaild_PicReg_Nums <= 0:
				#captcha.picRegCaptcha_cleared = true
		#elif is_in_group("Twos"):
			#add_theme_stylebox_override("normal", Twos_clicked)
			#clicked = true
	##if toggled_on:
		##if is_in_group("Ones"):
			##add_theme_stylebox_override("normal", Ones_normal)
			##clicked = false
		##elif is_in_group("Twos"):
			##add_theme_stylebox_override("normal", Twos_normal)
			##clicked = false
