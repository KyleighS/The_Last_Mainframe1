extends Node2D

func _on_area_2d_area_entered(area):
	area.get_parent().queue_free()
	queue_free()
