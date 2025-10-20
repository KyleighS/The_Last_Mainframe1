extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if draggable:
		#print("Draggable")
		if Input.is_action_just_pressed("Click"):
			#print("just clicked")
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("Click"):
			#print("Dragging")
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("Click"):
			#print("released")
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable and is_in_group("Ones"):
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				Global.valid_Nums -= 1
				print(Global.valid_Nums)
				queue_free() 
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered():
	#print("mouse entered")
	if not Global.is_dragging:
		draggable = true
		scale = Vector2(1, 1)

func _on_area_2d_mouse_exited():
	if not Global.is_dragging:
		draggable = false
		scale = Vector2(.8, .8)

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("dropable"):
		is_inside_dropable = true
		body_ref = body

func _on_area_2d_body_exited(body: Node2D):
	if body.is_in_group("dropable"):
		is_inside_dropable = false
