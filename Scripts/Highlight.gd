extends Node2D

@export var normal_color: Color = Color(1, 1, 1, 1)
@export var hover_color: Color = Color(0.907, 0.206, 0.295, 1.0) 

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func mouse_enter():
	modulate = hover_color

func mouse_exit(): 
	modulate = normal_color
