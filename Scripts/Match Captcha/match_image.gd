extends Node2D

# --- Images ---
@export var left_image_texture: Texture2D
@export var right_image_textures: Array[Texture2D] = []

@onready var left_image = $LeftImage
@onready var right_image = $RightImage
@onready var left_arrow = $LeftArrow
@onready var right_arrow = $RightArrow
@onready var match_verify_button = $MatchVerifyButton
@onready var error_label = $ErrorLabel
@onready var error_overlay = $ErrorOverlay
@onready var camera = $Camera2D
@onready var flash_timer = $FlashTimer

@onready var sfx_hover: AudioStreamPlayer = $"../SFX Hover"
@onready var sfx_click: AudioStreamPlayer = $"../SFX Click"
@onready var sfx_success: AudioStreamPlayer = $"../SFX Success"
@onready var sfx_failure: AudioStreamPlayer = $"../SFX Failure"
@onready var win_screen: Control = $"../WinScreen"

var current_index := 0
var original_camera_pos: Vector2
var shake_amount = 10
var shake_duration = 0.2
var shake_elapsed = 0.0
var shaking = false
var captcha_cleared = false

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
	
	#Generate random image sequence
	randomize()
	
	# Shuffle the right images
	right_image_textures.shuffle()
	current_index = 0
	
	# Pick a random left image, making sure it doesn't match the first right image
	left_image_texture = right_image_textures[randi() % right_image_textures.size()]
	while left_image_texture == right_image_textures[current_index]:
		left_image_texture = right_image_textures[randi() % right_image_textures.size()]
	
	error_label.visible = false
	error_overlay.visible = false
	original_camera_pos = camera.position
	flash_timer.one_shot = true
	flash_timer.wait_time = 0.4
	flash_timer.timeout.connect(reset_flash)

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
		sfx_success.play()
		#Engine.time_scale = 0
		get_tree().paused = false
		captcha_cleared = true
		#win_screen.show()
	else:
		print("Fail! Resetting scene.")
		sfx_failure.play()
		show_error_feedback()
		reset_captcha()

func _process(delta):
	if shaking:
		if shake_elapsed < shake_duration:
			var offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
			camera.position = original_camera_pos + offset
			shake_elapsed += delta
		else:
			camera.position = original_camera_pos
			shaking = false
			shake_elapsed = 0.0

# --- Reset function ---
func reset_captcha():
	current_index = 0
	right_image.texture = right_image_textures[current_index]
	left_image.texture = left_image_texture
	
# Show visual feedback
func show_error_feedback():
	error_label.text = "ERROR"
	error_label.visible = true
	error_overlay.visible = true
	flash_timer.start()
	start_screen_shake()
	
# Reset after flash
func reset_flash():
	error_overlay.visible = false
	error_label.visible = false
	
# Simple screen shake
func start_screen_shake():
	shaking = true
	shake_elapsed = 0.0
