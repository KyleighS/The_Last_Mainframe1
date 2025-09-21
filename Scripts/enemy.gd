extends Node2D

func _on_area_2d_area_entered(area):
	area.get_parent().queue_free()
	print("Enemy Killed")
	queue_free()
