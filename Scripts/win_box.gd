extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		body.get_node("CameraPoint/Camera2D/WinScreen").show()
		Engine.time_scale = 0
