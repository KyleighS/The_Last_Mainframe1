extends CharacterBody2D

@export var player: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 100

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $AnimatedSprite2D/RayCast2DRight
@onready var ray_cast_left: RayCast2D = $AnimatedSprite2D/RayCast2DLeft
@onready var timer: Timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var right_bound: Vector2
var left_bound: Vector2
var health = 10
var is_frozen = false

enum States{
	WANDER,
	CHASE
}

var current_state = States.WANDER

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	if !is_frozen:
		handle_movement(delta)

func chase_player():
	timer.stop()
	current_state = States.CHASE

func stop_chase():
	if timer.time_left <= 0:
		timer.start()


func handle_movement(delta: float) -> void:
	sprite.play("Walk")
	if current_state == States.WANDER:
		if ray_cast_right.is_colliding():
			direction = -1
			sprite.flip_h = true
		if ray_cast_left.is_colliding():
			direction = 1
			sprite.flip_h = false
		position.x += direction * SPEED * delta

	else:
		# chase state
		if !ray_cast_right.is_colliding() and !ray_cast_left.is_colliding():
			var direction_x = sign(player.position.x - position.x)
			if direction_x == 1:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
			position.x += direction_x * CHASE_SPEED * delta
		else:
			stop_chase()
			sprite.play("Idle")

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_timer_timeout() -> void:
	current_state = States.WANDER

#checks for player
func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		chase_player()
	elif current_state == States.CHASE:
		stop_chase()

#checks for bullets
func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("Bullet") and !is_frozen:
		take_damage(2, area)
			
	if area.is_in_group("Freeze"):
		freeze_enemy(5, area)
		
func take_damage(dmg, area):
		health -= dmg
		area.get_parent().queue_free()
		
		if health <= 0:
			area.get_parent().queue_free()
			print("Enemy Killed")
			queue_free()

func freeze_enemy(duration, area):
	area.get_parent().queue_free()
	is_frozen = true
	velocity = Vector2.ZERO
	sprite.stop()
	#process_mode = Node.PROCESS_MODE_DISABLED

	await get_tree().create_timer(duration).timeout

	#process_mode = Node.PROCESS_MODE_INHERIT
	is_frozen = false
	sprite.play("Walk")
	
