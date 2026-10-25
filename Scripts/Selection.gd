class_name Selection
extends Sprite2D

signal dropped(obj: Selection, zone: Area2D)
signal hovered(obj: Selection)
signal unhovered()

var clue_id: String
var description: String
var is_sufficient_proof: bool
var preview_texture: Texture2D

@onready var _area: Area2D = $Area2D

var interactable := false
var original_position: Vector2
var _is_dragging := false
var _offset: Vector2

func _ready() -> void:
	_area.collision_layer = 2
	_area.collision_mask = 1
	_area.input_pickable = false
	_area.monitoring = false

	_area.mouse_entered.connect(_on_area_mouse_entered)
	_area.mouse_exited.connect(_on_area_mouse_exited)
	_area.input_event.connect(_on_area_input_event)

# Appelée par Interactible
func setup(data: Dictionary) -> void:
	clue_id = data.get("id", "")
	description = data.get("description", "")
	is_sufficient_proof = data.get("is_sufficient_proof", false)
	
	# Chargement des images
	var scene_img: String = data.get("scene_image", "")
	if scene_img != "" and ResourceLoader.exists(scene_img):
		texture = load(scene_img)
		
	var preview_img: String = data.get("preview_image", "")
	if preview_img != "" and ResourceLoader.exists(preview_img):
		preview_texture = load(preview_img)
		
	original_position = global_position # Sauvegarde après placement
	interactable = true
	visible = true
	_area.input_pickable = true
	_area.set_deferred("monitoring", true)

func _on_area_mouse_entered() -> void:
	if interactable and not _is_dragging: hovered.emit(self)

func _on_area_mouse_exited() -> void:
	if interactable: unhovered.emit()

func _on_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not interactable: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_is_dragging = true
			_offset = get_global_mouse_position() - global_position
			z_index = 100
			unhovered.emit()
		elif _is_dragging:
			_is_dragging = false
			z_index = 10
			for area in _area.get_overlapping_areas():
				if area is Drop_Zone:
					dropped.emit(self, area)
					return
			global_position = original_position

func _input(event: InputEvent) -> void:
	if _is_dragging and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() - _offset
