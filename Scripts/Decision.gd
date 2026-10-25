class_name Decision
extends PopupPanel

enum Choice { CONDEMN, INNOCENT, CANCEL }
signal decision_made(choice: Choice)

@onready var _condemn_button: Button = $VBoxContainer/CondemnButton
@onready var _Innocent_button: Button = $VBoxContainer/InnocentButton
@onready var _cancel_button: Button = $VBoxContainer/CancelButton

func _ready() -> void:
	exclusive = true
	_condemn_button.pressed.connect(_on_condemn_pressed)
	_Innocent_button.pressed.connect(_on_Innocent_pressed)
	_cancel_button.pressed.connect(_on_cancel_pressed)

func _on_condemn_pressed() -> void:
	_make_decision(Choice.CONDEMN)

func _on_Innocent_pressed() -> void:
	_make_decision(Choice.INNOCENT)

func _on_cancel_pressed() -> void:
	_make_decision(Choice.CANCEL)

func _make_decision(choice: Choice) -> void:
	decision_made.emit(choice)
	hide()
