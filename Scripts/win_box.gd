extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.get_node("CameraPoint/WinScreen").show()
		Engine.time_scale = 0
