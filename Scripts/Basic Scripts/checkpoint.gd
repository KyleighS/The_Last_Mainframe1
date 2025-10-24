extends Area2D

var checkpoint_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_manager = get_parent().get_parent().get_node("CheckpointManager")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player entered checkpoint")
		checkpoint_manager.last_location = $RespawnPoint.global_position
		print(checkpoint_manager.last_location)
