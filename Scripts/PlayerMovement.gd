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

#Health System
var max_health = 3
var _health = max_health
@onready var respawn_timer = $RespawnTimer
@onready var imunity_timer = $ImunityTimer
var can_damage = true


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
	heal()
	
func shoot(dir):
	if Input.is_action_just_pressed("Shoot"):
		bulletObj = bullet.instantiate()
		bulletObj.init(dir)
		get_parent().add_child(bulletObj)
		bulletObj.global_position = $Marker2D.global_position
		

#Health Functions
func _on_area_2d_area_entered(area: Area2D) -> void:
	#checks if it was an enemy and if the player can take damage
	if area.is_in_group("Enemy") && can_damage:
		#subtracst health from player
		_health -= 1
		get_node("Camera2D/HealthBar").get_child(_health).queue_free()
		print("player damaged ", _health)
		#starts imunity
		can_damage = false
		print("imunity starts")
		imunity_timer.start()
		
		#kills player
		if _health <= 0:
			Engine.time_scale = 0.5
			respawn_timer.start()
			get_node("CollisionShape2D").queue_free()
			#get_tree().reload_current_scene()
			print("Player Killed")

#for respawn timer
func _on_respawn_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

#for imunity timer, allows player to take damage again
func _on_imunity_timer_timeout():
	can_damage = true
	print("imunity ends")

func heal():
	if Input.is_action_just_pressed("Heal"):
		_health += 1
		#aget_node("Camera2D/HealthBar")a.add_child(heart)
		if _health > max_health:
			_health = max_health
			
		print("player healed to ", _health)
