extends Control

@onready var scene = $"../../../"

func _on_resume_pressed() -> void:
	scene.pauseMenu()
	

func _on_quit_pressed() -> void:
	get_tree().quit()
	
