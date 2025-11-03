extends CharacterBody2D

@export var player: CharacterBody2D
@export var SPEED: int = 50
@export var CHASE_SPEED: int = 150
@export var ACCELERATION: int = 300

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $AnimatedSprite2D/RayCast2D
@onready var timer: Timer = $Timer

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2
var right_bound: Vector2
var left_bound: Vector2

enum States{
	WANDER,
	CHASE
}

var current_state = States.WANDER

func _ready():
	left_bound = self.position + Vector2(-600, 0)
	right_bound = self.position + Vector2(600, 0)

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_player()
	

func look_for_player():
	#print("looking for player")
	if ray_cast.is_colliding():
		print("getting raycast")
		var collider = ray_cast.get_collider()
		print(collider)
		if collider == player:
			chase_player()
		elif current_state == States.CHASE:
			stop_chase()
	elif current_state == States.CHASE:
		stop_chase()

func chase_player():
	timer.stop()
	current_state = States.CHASE

func stop_chase():
	if timer.time_left <= 0:
		timer.start()

func handle_movement(delta: float) -> void:
	if current_state == States.WANDER:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)
	
	move_and_slide()

func change_direction() -> void:
	if current_state == States.WANDER:
		if sprite.flip_h:
			#moving right
			if self.position.x <= right_bound.x:
				direction = Vector2(1, 0)
			else:
				#flip to move left
				sprite.flip_h = false
				ray_cast.target.position = Vector2(600, 0)
		else:
			#moving left
			if self.position.x >= left_bound.x:
				direction = Vector2(-1, 0)
			else:
				#flip to moving right
				sprite.flip.h = true
				ray_cast.target_position = Vector2(-600, 0)
	else:
		#chase state
		direction = (player.position - self.position).normalized()
		direction = sign(direction)
		if direction.x == 1:
			#flip to moving right
			sprite.flip_h = true
			ray_cast.target_position = Vector2(600, 0)
		else:
			#flip to move left
			sprite.flip_h = false
			ray_cast.target.position = Vector2(-600, 0)

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _on_timer_timeout() -> void:
	current_state = States.WANDER
