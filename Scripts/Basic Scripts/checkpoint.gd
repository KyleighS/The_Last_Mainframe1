extends Area2D

var checkpoint_manager
@onready var sfx_check_point: AudioStreamPlayer = $SFX_CheckPoint
var checkpointReached = false
@onready var player: CharacterBody2D = $"../../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_manager = get_parent().get_parent().get_node("CheckpointManager")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("player entered checkpoint")
		checkpoint_manager.last_location = $RespawnPoint.global_position
		player.
		if !checkpointReached:
			sfx_check_point.play()
			checkpointReached = true
		print(checkpoint_manager.last_location)
