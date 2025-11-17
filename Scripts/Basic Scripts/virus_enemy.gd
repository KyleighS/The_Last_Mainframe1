extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

const speed : int = 30
const chase_speed : int = 60
var dir : Vector2
var player : CharacterBody2D
var health : int = 10
var is_frozen : bool = false

enum States{
	WANDER,
	CHASE
}

var current_state = States.WANDER

func _ready():
	player = Global.playerBody

func _process(delta: float):
	if !is_frozen:
		move(delta)
		animations()

func move(delta):
	if current_state == States.CHASE:
		velocity = position.direction_to(player.position) * chase_speed
		dir.x = (abs(velocity.x) / velocity.x)
	elif current_state == States.WANDER:
		velocity += dir * speed * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	current_state = States.WANDER
	timer.wait_time = choose([1.0, 1.5, 2.0])
	if current_state == States.WANDER:
		dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.DOWN, Vector2.LEFT])

func animations():
	animated_sprite.play("Fly")
	if dir.x == -1:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func choose(array):
	array.shuffle()
	return array.front()

func chase_player():
	timer.stop()
	current_state = States.CHASE

func stop_chase():
	if timer.time_left <= 0:
		timer.start()

#checks for player
func _on_player_detection_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		print("player detected")
		chase_player()
	elif current_state == States.CHASE:
		stop_chase()

func _on_body_collision_area_entered(area: Area2D) -> void:
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
	animated_sprite.stop()
	#process_mode = Node.PROCESS_MODE_DISABLED

	await get_tree().create_timer(duration).timeout

	#process_mode = Node.PROCESS_MODE_INHERIT
	is_frozen = false
	animations()
