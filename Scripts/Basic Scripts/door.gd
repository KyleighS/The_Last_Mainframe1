extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	interactable.interact = on_interact

func on_interact():
	print("door unlocked")
	queue_free()
