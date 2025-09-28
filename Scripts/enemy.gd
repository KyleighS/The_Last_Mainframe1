extends Node2D

var health = 10

func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullet"):
		health -=2
		area.get_parent().queue_free()
		
		if health <= 0:
			area.get_parent().queue_free()
			print("Enemy Killed")
			queue_free()
