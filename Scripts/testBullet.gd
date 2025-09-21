extends Sprite2D

func _ready():
	scale = Vector2(.5, .5)

func _physics_process(delta: float):
	position.x += 8


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
