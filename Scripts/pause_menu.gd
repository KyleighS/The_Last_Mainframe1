extends Control

@onready var scene: Node2D = $".."


func _on_resume_pressed():
	$"SFX Click".play()
	scene.pauseMenu()

func _on_main_menu_pressed() -> void:
	$"SFX Click".play()
	get_tree().change_scene_to_file("res://Scenes/MainMenu")

func _on_quit_pressed() -> void:
	$"SFX Click".play()
	get_tree().quit()

func _on_resume_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_main_menu_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_quit_mouse_entered() -> void:
	$"SFX Hover".play()
