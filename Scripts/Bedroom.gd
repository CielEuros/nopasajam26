extends Node2D

var hand_cursor = preload("res://Assets/Placeholder-hand-interract.png")

@onready var tiroirs_loader := $Tiroirs/TiroirsHintLoader
@onready var tiroirs_popup := $Tiroirs/TiroirsHintPopup

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func change_cursor_hand():
	Input.set_custom_mouse_cursor(hand_cursor)
	tiroirs_popup.visible = true

func change_cursor_back():
	Input.set_custom_mouse_cursor(null)
	tiroirs_popup.visible = false


func _tiroirs_click(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				tiroirs_loader.start()
				tiroirs_loader.visible = true
		elif event.is_released():
			if event.button_index == MOUSE_BUTTON_LEFT:
				tiroirs_loader.stop()
				tiroirs_loader.visible = false
