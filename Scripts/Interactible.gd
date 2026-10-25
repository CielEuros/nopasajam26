extends Node2D

@export var polaroid_scene: PackedScene #scene a part pour la cree de façon adaptative à la database
@export var spacing: Vector2 = Vector2(18, 18)
@export var start_position: Vector2 = Vector2(160, 64)
@export var polaroid_columns: int = 3

@export_group("Scene Transitions")
@export var compliance_scene: PackedScene
@export var revolution_scene: PackedScene
@export var incompetence_scene: PackedScene

@export_group("End Sequence")
@export var stamp_display_time: float = 1.0
@export var ink_display_time: float = 1.5
@export var ink_condemn: Texture2D
@export var ink_innocent: Texture2D

@onready var _objects_container: Node2D = $Container_polaroid
@onready var _preview: Preview = $Preview
@onready var _stamp: Sprite2D = $Stamp
@onready var _ink: Sprite2D = $Ink
@onready var _decision: PopupPanel = $DecisionPopUp
@onready var _stamp_zone: Area2D = $Area_Stamp_zone

var _selected: Array[Selection] = []
var _is_transitioning : bool = false

func _ready() -> void:
	_stamp.hide()
	_ink.hide()

	_decision.exclusive = true
	_stamp_zone.input_event.connect(_on_stamp_zone_clicked)

	_spawn_polaroids()

func _spawn_polaroids() -> void:
	var clues_data = CodeDictionnary.get_found_clues_data()
	
	# On boucle sur chaque preuve avec son index (i)
	for i in range(clues_data.size()):
		var data = clues_data[i]
		var polaroid = polaroid_scene.instantiate() as Selection
		_objects_container.add_child(polaroid)
		
		#Permet que tout les 3 colonnes on revienne à la ligne
		var col : int = i % polaroid_columns
		var row : int = i / polaroid_columns
		
		# On calcule la position finale
		var pos_x = start_position.x + (col * spacing.x)
		var pos_y = start_position.y + (row * spacing.y)
		
		polaroid.global_position = Vector2(pos_x, pos_y)
		polaroid.z_index = 10
		
		polaroid.setup(data)
		
		polaroid.dropped.connect(_on_object_dropped)
		polaroid.hovered.connect(_on_object_hovered)
		polaroid.unhovered.connect(_on_object_unhovered)

func _on_object_hovered(obj: Selection) -> void:
	if is_instance_valid(_preview): 
		_preview.show_preview(obj)

func _on_object_unhovered() -> void:
	if is_instance_valid(_preview): 
		_preview.hide_preview()

func _on_stamp_zone_clicked(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var is_pressed = event
	if is_pressed is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not _is_transitioning and is_pressed:
			_decision.popup_centered()

func _on_object_dropped(obj: Selection, zone: Area2D) -> void:
	if obj not in _selected: _selected.append(obj)
	if zone is Drop_Zone: zone.receive_object(obj)

func _on_condemn_button_pressed() -> void:
	_decision.hide()
	_play_ending_sequence(true)

func _on_innocent_button_pressed() -> void:
	_decision.hide()
	_play_ending_sequence(false)

func _on_cancel_button_pressed() -> void:
	_decision.hide()

func _play_ending_sequence(condemns: bool) -> void:
	_is_transitioning = true
	if is_instance_valid(_decision): 
		_decision.hide()
	
	_stamp.show()
	_ink.hide()
	await get_tree().create_timer(stamp_display_time).timeout

	_stamp.hide()
	if condemns:
		_ink.texture = ink_condemn
	else:
		_ink.texture = ink_innocent
	_ink.show()
	await get_tree().create_timer(ink_display_time).timeout

	var target: PackedScene
	if condemns: 
		target = compliance_scene
	else:
		if _has_sufficient_proof(): 
			target = revolution_scene
		else: 
			target = incompetence_scene

	get_tree().change_scene_to_packed(target)

func _has_sufficient_proof() -> bool:
	for obj in _selected:
		if obj.is_sufficient_proof: 
			return true
	return false
