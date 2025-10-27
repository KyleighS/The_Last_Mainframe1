extends Control

func _on_play_pressed() -> void:
	$"SFX Click".play()
	get_tree().change_scene_to_file("res://Scenes/BasicGame/game.tscn")

func _on_quit_pressed() -> void:
	$"SFX Click".play()
	get_tree().quit()

func _on_options_pressed() -> void:
	$"SFX Click".play()
	print("Options pressed. Pending creation.")

func _on_play_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_options_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_quit_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_drag_captcha_pressed() -> void:
	$"SFX Click".play()
	get_tree().change_scene_to_file("res://Scenes/DragCaptcha/drag_captcha.tscn")

func _on_drag_captcha_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_match_captcha_pressed() -> void:
	$"SFX Click".play()
	get_tree().change_scene_to_file("res://Scenes/MatchCaptcha/match_captcha.tscn")

func _on_match_captcha_mouse_entered() -> void:
	$"SFX Hover".play()
