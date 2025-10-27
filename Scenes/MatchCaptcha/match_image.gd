extends Node2D

# --- Images ---
@export var left_image_texture: Texture2D
@export var right_image_textures: Array[Texture2D] = []

@onready var left_image = $LeftImage
@onready var right_image = $RightImage
@onready var left_arrow = $LeftArrow
@onready var right_arrow = $RightArrow
@onready var match_verify_button = $MatchVerifyButton

var current_index := 0

func _ready():
	# Example: preload images
	left_image_texture = preload("res://Assets/images/match_captcha/right2.jpg")
	right_image_textures = [
		preload("res://Assets/images/match_captcha/right1.jpg"),
		preload("res://Assets/images/match_captcha/right2.jpg"),
		preload("res://Assets/images/match_captcha/right3.jpg"),
		preload("res://Assets/images/match_captcha/right4.jpg"),
		preload("res://Assets/images/match_captcha/right5.jpg")
	]

	# Assign to the UI
	left_image.texture = left_image_texture
	right_image.texture = right_image_textures[current_index]

# --- Button callbacks ---
func _on_left_arrow_pressed():
	if right_image_textures.size() == 0:
		return
	current_index -= 1
	if current_index < 0:
		current_index = right_image_textures.size() - 1
	right_image.texture = right_image_textures[current_index]

func _on_right_arrow_pressed():
	if right_image_textures.size() == 0:
		return
	current_index += 1
	if current_index >= right_image_textures.size():
		current_index = 0
	right_image.texture = right_image_textures[current_index]

func _on_match_verify_button_pressed():
	if left_image.texture == right_image.texture:
		print("Success! Images match.")
	else:
		print("Fail! Resetting scene.")
		reset_captcha()

# --- Reset function ---
func reset_captcha():
	current_index = 0
	right_image.texture = right_image_textures[current_index]
	left_image.texture = left_image_texture
