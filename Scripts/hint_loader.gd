class_name HintLoader
extends Node2D

@export_range(0, 100) var value: int = 0
var started := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func start() -> void:
	started = true
	value = 0

func stop() -> void:
	started = false
	#value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		value = clampi(value + 1, 0, 100)
	$TextureProgressBar.value = value
