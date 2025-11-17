extends CharacterBody2D

var speed = 250

func _ready() -> void:
	velocity = Vector2(-200, -200).normalized() * speed

func _physics_process(delta: float):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func _on_CharacterBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Character clicked!")
		get_viewport().set_input_as_handled() # stops click propagation
