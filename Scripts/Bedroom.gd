extends Node2D

var hand_cursor = preload("res://Assets/Placeholder-hand-interract.png")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	

func change_cursor_hand():
	Input.set_custom_mouse_cursor(hand_cursor)

func change_cursor_back():
	Input.set_custom_mouse_cursor(null)
