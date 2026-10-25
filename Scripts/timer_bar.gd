class_name TimerBar
extends HBoxContainer

@export_range(1, 10) var remaining: int

func update(rem: int) -> void:
	remaining = rem
	$RemainingChronos.custom_maximum_size = Vector2(remaining * 18, 21)
	$SpentChronos.custom_maximum_size = Vector2((10 - remaining) * 8, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
