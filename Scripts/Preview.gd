class_name Preview
extends Node2D

@onready var _sprite: Sprite2D = $Zoom_polaroid
@onready var _label: Label = $Label

func _ready() -> void:
	z_index = 100
	hide()

# cf Code_Dictionnary.gd -> DATABASE
func show_preview_from_dict(dict: Dictionary) -> void:
	var preview_image = dict.get("preview_image", "")
	var description = dict.get("description", "")
	if preview_image == "" or description == "":
		hide()
		return
		
	# Image et texte
	if ResourceLoader.exists(preview_image):
		_sprite.texture = load(preview_image)
	_label.text = description
		
	show()

func show_preview(obj: Selection) -> void:
	# Verification objet
	if not is_instance_valid(obj): 
		return
		
	# Verification preview
	if not obj.preview_texture:
		hide()
		return
		
	# Image et texte
	_sprite.texture = obj.preview_texture
	
	if obj.description != "":
		_label.text = obj.description
	else:
		_label.text = "(aucune description)"
		
	show()

func hide_preview() -> void:
	hide()
