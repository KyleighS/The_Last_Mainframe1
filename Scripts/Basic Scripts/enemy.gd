extends Node2D

var health = 10
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullet"):
		health -=2
		animated_sprite_2d.play("Hurt")
		area.get_parent().queue_free()
		
		if health <= 0:
			area.get_parent().queue_free()
			animated_sprite_2d.play("Death")
			print("Enemy Killed")
			queue_free()
