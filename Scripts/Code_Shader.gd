extends Area2D

@export var effect_strength: float = 0.1

var _sprite: Sprite2D

func _ready() -> void:
	_sprite = _find_sprite_upward(self)
	_sprite.material = _sprite.material.duplicate()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _find_sprite_upward(node: Node) -> Sprite2D:
	var current := node.get_parent()
	while current != null:
		if current is Sprite2D:
			return current
		current = current.get_parent()
	return null

func _on_mouse_entered() -> void:
	_sprite.material.set_shader_parameter("hover_active", effect_strength)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited() -> void:
	_sprite.material.set_shader_parameter("hover_active", 0.0)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
