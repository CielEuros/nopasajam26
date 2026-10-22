class_name Hint
extends Resource

static var DEFAULT := Hint.new(2, "PLACEHOLDER", "Ceci est un placeholder, pas vraiment intéressant")

@export var name: String
@export var description: String
@export_range(0, 5) var cost: int
@export var major: bool

func _init(p_cost = 0, p_name = "", p_description = "", p_major = false):
	cost = p_cost
	name = p_name
	description = p_description
	major = p_major
