class_name Drop_Zone
extends Area2D

@export var placement_offset: Vector2 = Vector2 (4.0, 2.0)
var contained_object: Selection

func _ready() -> void:
	collision_layer = 1
	collision_mask = 0

func receive_object(obj: Selection) -> void:
	# Si un objet est déjà là, on le renvoie à sa position d'origine
	if is_instance_valid(contained_object) and contained_object != obj:
		contained_object.global_position = contained_object.original_position
		contained_object.z_index = 10

	contained_object = obj
	obj.z_index = 10
	
	var target_pos: Vector2 = global_position
	
	# On cherche l'image pour récupérer sa position
	for child in get_children():
		if child is Node2D:
			target_pos = child.global_position
			break
	obj.global_position = target_pos + placement_offset
