extends CharacterBody2D

@onready var bullet = preload("res://Scenes/TestingScenes/bullet.tscn")
var bulletObj

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Gets the input direction
var direction = Input.get_axis("Move_Left", "Move_Right")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move_Left", "Move_Right")
	# Applys the movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Flips the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Plays the animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Walk")
	else:
		animated_sprite.play("Jump")
	shoot(animated_sprite.flip_h)
	move_and_slide()
	
func shoot(dir):
	if Input.is_action_just_pressed("Shoot"):
		bulletObj = bullet.instantiate()
		bulletObj.init(dir)
		get_parent().add_child(bulletObj)
		bulletObj.global_position = $Marker2D.global_position
