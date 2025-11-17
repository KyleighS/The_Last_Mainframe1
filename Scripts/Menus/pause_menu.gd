extends Control

@onready var scene: Node2D = $"../../../.."
@onready var options_menu: Control = $OptionsMenu
@onready var menu_bg: ColorRect = $MenuBG


func _on_resume_pressed():
	$"SFX Click".play()
	scene.pauseMenu()

func _on_main_menu_pressed() -> void:
	$"SFX Click".play()
	get_tree().change_scene_to_file("res://Scenes/MainMenu")

func _on_quit_pressed() -> void:
	$"SFX Click".play()
	get_tree().quit()

func _on_options_pressed() -> void:
	$"SFX Click".play()
	options_menu.show()
	menu_bg.hide()

func _on_resume_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_main_menu_mouse_entered() -> void:
	$"SFX Hover".play()

func _on_quit_mouse_entered() -> void:
	$"SFX Hover".play()
