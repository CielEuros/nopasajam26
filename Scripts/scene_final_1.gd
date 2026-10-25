extends Node2D

var JUGEMENT_SCENE : PackedScene = preload("res://Scenes/Jugement.tscn")
var current_discoverable_hint: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_clear_investigate_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _clear_investigate_ui() -> void:
	%Description.text = ""
	%Instructions.text = ""
	%SearchButton.visible = false
	%CloseButton.visible = false
	current_discoverable_hint = ""

func _set_investigate_ui(hint_id: String, description: String, cost: int) -> void:
	if !CodeDictionnary.DATABASE.has(hint_id):
		_clear_investigate_ui()
		#TODO error
	
	current_discoverable_hint = hint_id
	%Description.text = description
	if cost > 0:
		%Instructions.text = str("[i]Il y a peut-être un indice ici, investiguer coûtera[/i] [b]", cost, " point", "s" if cost > 1 else "", " d'action[/b]")
		%Instructions.visible = true
		%SearchButton.text = str("Chercher (", cost, ")")
		%SearchButton.visible = true
	else:
		%Instructions.visible = false
		%SearchButton.visible = false
	%CloseButton.visible = true

func _set_investigate_clue_found(id: String) -> void:
	_clear_investigate_ui()
	if !CodeDictionnary.DATABASE.has(id):
		return
	var hint: Dictionary = CodeDictionnary.DATABASE.get(id)
	print("Found: ", hint)
	%Description.text = str("Nouvel indice trouvé : ", hint["description"])
	%CloseButton.visible = true
	
func _buffet_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		_set_investigate_ui("", "Le buffet a l'air ancien mais n'a pas de tiroir secret. Peut-être devrais-je regarder les livres ?", 0)


func _tirroir_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		_set_investigate_ui("Livre_Noir", "Le tiroir contient un livre à la couverture entièrement noire", 1)


func _on_search_button_pressed() -> void:
	if current_discoverable_hint != "":
		CodeDictionnary.register_found_clue(current_discoverable_hint)
		_set_investigate_clue_found(current_discoverable_hint)
		var rem = $TimerBar.remaining - 1
		$TimerBar.update(rem)
	else:
		_clear_investigate_ui()


func _on_close_button_pressed() -> void:
	_clear_investigate_ui()


func _on_end_button_pressed() -> void:
	get_tree().change_scene_to_packed(JUGEMENT_SCENE)
