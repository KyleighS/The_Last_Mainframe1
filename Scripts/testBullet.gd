extends Sprite2D

var direction = false

func init(dir):
	direction = dir

func _ready():
	scale = Vector2(2, 2)

func _physics_process(delta):
	if direction:
		position.x += 8
	else:
		position.x -= 8

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
