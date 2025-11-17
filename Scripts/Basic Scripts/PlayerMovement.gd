extends CharacterBody2D

@onready var gun_stamina: ProgressBar = $CameraPoint/Camera2D/GunStamina
var maxStamina
#regular bullets
@onready var reg_bullet = preload("res://Scenes/BasicGame/RegBullet.tscn")
var reg_bulletObj
#freezeing
@onready var freeze_bullet = preload("res://Scenes/BasicGame/FreezeBullet.tscn")
var freeze_bulletObj
var freeze_toggled = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var checkpoint_manager
var player

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Gets the input direction
var direction = Input.get_axis("Move_Left", "Move_Right")

#Health System
var max_health = 3
var _health = max_health
@onready var respawn_timer = $RespawnTimer
@onready var imunity_timer = $ImunityTimer
var can_damage = true
@export var knockbcakPower: int = 3000

func _ready() -> void:
	checkpoint_manager = get_parent().get_node("CheckpointManager")
	player = get_parent().get_node("Player")
	Global.playerBody = self
	gun_stamina.value = 10

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
		animated_sprite.flip_h = true
	elif direction < 0:
		animated_sprite.flip_h = false
	
	# Plays the animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	#for shooting/freezing
	if Input.is_action_just_pressed("Freeze"):
		freeze_toggled = !freeze_toggled
	if Input.is_action_just_pressed("Shoot") and Engine.time_scale == 1 and gun_stamina.value > 0:
		gun_stamina.value -= 1
		if !freeze_toggled:
			shoot(animated_sprite.flip_h)
		if freeze_toggled:
			freeze(animated_sprite.flip_h)
	move_and_slide()
	heal()
	
#regular shooting
func shoot(dir):
		animated_sprite.play("Shooting")
		reg_bulletObj = reg_bullet.instantiate()
		reg_bulletObj.init(dir)
		get_parent().add_child(reg_bulletObj)
		if !animated_sprite.flip_h:
			reg_bulletObj.flip_h = true
			reg_bulletObj.global_position = $ShootPointLeft.global_position
		else:
			reg_bulletObj.flip_h = false
			reg_bulletObj.global_position = $ShootPointRight.global_position
		
#freezeing
func freeze(dir):
		animated_sprite.play("Shooting")
		freeze_bulletObj = freeze_bullet.instantiate()
		freeze_bulletObj.init(dir)
		get_parent().add_child(freeze_bulletObj)
		if !animated_sprite.flip_h:
			freeze_bulletObj.flip_h = true
			freeze_bulletObj.global_position = $ShootPointLeft.global_position
		else:
			freeze_bulletObj.flip_h = false
			freeze_bulletObj.global_position = $ShootPointRight.global_position

#Health Functions
func _on_area_2d_body_entered(body: Node2D) -> void:
		#checks if it was an enemy and if the player can take damage
	if body.is_in_group("Enemy") && can_damage:
		#subtracst health from player
		_health -= 1
		get_node("CameraPoint/Camera2D/HealthBar").get_child(_health + 3).hide()
		print("player damaged ", _health)
		animated_sprite.play("Hit")
		knockback()
		#starts imunity
		can_damage = false
		print("imunity starts")
		imunity_timer.start()
		
		#kills player
		if _health <= 0:
			animated_sprite.play("Die")
			Engine.time_scale = 0.5
			respawn_timer.start()
			get_node("CollisionShape2D").hide()
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
		if _health == max_health:
			return
		_health += 1
		get_node("CameraPoint/Camera2D/HealthBar").get_child(_health + 2).show()
		if _health > max_health:
			_health = max_health
			
		print("player healed to ", _health)

func knockback():
	#Note: revisit enemies knocing the player when they are just standing when
	#I remake the movement of the enemies
	if is_on_floor():
		var knockbackDir = -velocity.normalized() * knockbcakPower
		velocity = knockbackDir
		move_and_slide()
