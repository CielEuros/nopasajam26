class_name Preview
extends Node2D

@onready var _sprite: Sprite2D = $Zoom_polaroid
@onready var _label: Label = $Label

func _ready() -> void:
	z_index = 100
	hide()

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
