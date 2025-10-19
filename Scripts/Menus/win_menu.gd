extends Control

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_replay_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	Global.numOnes = 3
	Global.all_ones_gone = false
