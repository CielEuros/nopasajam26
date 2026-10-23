extends Camera2D

@export var SPEED: float = 100.0
@export var ZOOM_SPEED: float = 0.1
@export var zoom_min: Vector2 = Vector2(3.6, 3.6)
@export var zoom_max: Vector2 = Vector2(5.8, 5.8)
@export var position_left_max : Vector2 = Vector2(160.0,90)
@export var position_right_max : Vector2 = Vector2(260.0,90)

func _process(delta: float) -> void:
	var direction:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Left") : position += Vector2.LEFT * SPEED * delta
	if Input.is_action_pressed("Right") : position += Vector2.RIGHT * SPEED * delta
	position = position.clamp(position_left_max,position_right_max)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Zoom_In"): zoom += Vector2(ZOOM_SPEED, ZOOM_SPEED)
	if event.is_action_pressed("Zoom_Out"): zoom -= Vector2(ZOOM_SPEED, ZOOM_SPEED)
	zoom = zoom.clamp(zoom_min, zoom_max)
