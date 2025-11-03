extends Node2D

var draggable = false
var is_inside_dropable = false
var offset: Vector2
var initialPos: Vector2
var body_ref: StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var end_zone: StaticBody2D = get_parent().get_node("End_Zone")  # adjust path if needed

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(delta: float) -> void:
	manual_overlap_check()

	if draggable:
		if Input.is_action_just_pressed("Click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true

		if Input.is_action_pressed("Click"):
			global_position = get_global_mouse_position() - offset

		elif Input.is_action_just_released("Click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()

			if is_inside_dropable and is_in_group("Ones"):
				print("Dropped on End_Zone!")
				Global.valid_Nums -= 1
				queue_free()
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


# --- Manual overlap detection using center-inside logic ---
func manual_overlap_check() -> void:
	if not area_2d or not end_zone:
		return

	# Get draggable's center
	var draggable_center = area_2d.global_position

	# Get end zone rectangle
	var zone_shape = end_zone.get_node("CollisionShape2D") as CollisionShape2D
	if zone_shape == null:
		return

	var zone_rect = get_shape_global_rect(zone_shape)

	# Check if the center of draggable is inside end zone rectangle
	if zone_rect.has_point(draggable_center):
		if not is_inside_dropable:
			print("Entered End_Zone (center-inside)")
		is_inside_dropable = true
		body_ref = end_zone
	else:
		if is_inside_dropable:
			print("Exited End_Zone (center-inside)")
		is_inside_dropable = false
		body_ref = null


# --- Helper: get rectangle in global space from CollisionShape2D ---
func get_shape_global_rect(shape_node: CollisionShape2D) -> Rect2:
	var shape = shape_node.shape
	if shape is RectangleShape2D:
		var extents = shape.extents
		var top_left = shape_node.global_position - extents
		return Rect2(top_left, extents * 2)
	else:
		# fallback small rectangle for other shapes
		return Rect2(shape_node.global_position - Vector2(5, 5), Vector2(10, 10))


func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(1, 1)

func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = false
		scale = Vector2(0.8, 0.8)
