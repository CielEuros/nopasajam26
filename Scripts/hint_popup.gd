class_name HintPopup
extends Node2D

@export var hint: Hint = Hint.DEFAULT

@onready var Description := %Description
@onready var Instructions := %Instructions
@onready var Investiguer := %InvestiguerButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Description.text = hint.description
	if hint.cost > 0:
		var instruction := str("[i]Il y a peut-être un indice ici, investiguer coûtera[/i] [b]", hint.cost, " point", "s" if hint.cost > 1 else "", " d'action[/b]")
		Investiguer.text = str("Investiguer (", hint.cost, ")")
		Instructions.text = instruction
		Instructions.visible = true
	else:
		Instructions.visible = false
		Investiguer.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
