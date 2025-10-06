extends Area2D

@onready var timer = $Timer
var checkpoint_manager
var player

func _ready() -> void:
	checkpoint_manager = get_parent().get_node("CheckpointManager")
	player = get_parent().get_node("Player")

func _on_body_entered(body):
	#get_tree().reload_current_scene()
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	player.position = checkpoint_manager.last_location
