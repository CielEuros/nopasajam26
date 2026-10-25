extends Node2D

var JUGEMENT_SCENE : PackedScene = preload("res://Scenes/Jugement.tscn")
var current_discoverable_hint: String = ""
var collecte_level := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_clear_investigate_ui()
	BackgroundMusicPlayer.play_collecte(-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _clear_investigate_ui() -> void:
	%Description.text = ""
	%Instructions.text = ""
	%SearchButton.visible = false
	%NextButton.visible = false
	%CloseButton.visible = false
	current_discoverable_hint = ""
	%PreviewBgBlur.visible = false

func _set_investigate_ui_container(action: String, description: String, cost: int, on_click: Callable) -> void:
	%Description.text = description
	%Instructions.text = str("[i]Il y a peut-être un indice ici, investiguer coûtera[/i] [b]", cost, " point", "s" if cost > 1 else "", " d'action[/b]")
	%Instructions.visible = true
	%NextButton.text = action
	%NextButton.visible = true
	%SearchButton.visible = false
	%NextButton.connect("pressed", func spend_and_call():
		_spend(cost)
		on_click.call()
	, CONNECT_ONE_SHOT)
	

func _set_investigate_ui(hint_id: String, action: String, description: String, cost: int) -> void:
	if !CodeDictionnary.DATABASE.has(hint_id):
		_clear_investigate_ui()
		#TODO error
	
	current_discoverable_hint = hint_id
	%Description.text = description
	if cost > 0:
		%Instructions.text = str("[i]Il y a peut-être un indice ici, investiguer coûtera[/i] [b]", cost, " point", "s" if cost > 1 else "", " d'action[/b]")
		%Instructions.visible = true
		%SearchButton.text = "Récupérer" if action.is_empty() else action
		%SearchButton.visible = true
	else:
		%Instructions.visible = false
		%SearchButton.visible = false
	%CloseButton.visible = true
	%NextButton.visible = false

func _set_investigate_clue_found(id: String) -> void:
	_clear_investigate_ui()
	if !CodeDictionnary.DATABASE.has(id):
		return
	var hint: Dictionary = CodeDictionnary.DATABASE.get(id)
	print("Found: ", hint)
	%Description.text = "Nouvel indice trouvé : "
	%PreviewBgBlur.visible = true
	%Preview.show_preview_from_dict(hint)
	%CloseButton.visible = true
	
func _buffet_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		_set_investigate_ui_container("Inspecter la structure", "Un buffet à l'air ancien et aux nombreux tiroirs", 5,
			_set_investigate_ui.bind("", "", "Le buffet n'a pas de tiroir secret. Peut-être devrais-je regarder les livres ?", 0))

func _livres_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		_set_investigate_ui_container("Inspecter les Livres", "De nombreux livres sont rangés sur 2 étagères", 1,
			_set_investigate_ui.bind("1984", "Prendre le Livre", "Un livre dépasse avec une couverture plus grande que les autres", 1))

func _tirroir_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		_set_investigate_ui_container("Ouvrir le Tiroir", "Tiroir de bureau: la poussière s'est accumulée sauf sur ce tiroir", 1,
			_set_investigate_ui.bind("Livre_Noir", "Prendre le Livre", "Le tiroir contient un livre à la couverture entièrement noire", 1))

func _spend(cost: int) -> void:
	var rem = clampi($ResourceBar.remaining - cost, 0, 10)
	$ResourceBar.update(rem)
	collecte_level = clampi(collecte_level + cost, 0, 10)
	BackgroundMusicPlayer.play_collecte(collecte_level)
	if collecte_level >= 10:
		await get_tree().create_timer(0.5).timeout
		%PreviewBgBlur.visible = true
		%Preview.visible = false
		%CloseButton.disconnect("pressed", _on_close_button_pressed)
		%CloseButton.connect("pressed", _on_end_button_pressed)

func _on_search_button_pressed() -> void:
	if current_discoverable_hint != "":
		CodeDictionnary.register_found_clue(current_discoverable_hint)
		_set_investigate_clue_found(current_discoverable_hint)
		_spend(1)
	else:
		_clear_investigate_ui()

func _on_close_button_pressed() -> void:
	_clear_investigate_ui()
	%PreviewBgBlur.visible = false


func _on_end_button_pressed() -> void:
	BackgroundMusicPlayer.stop()
	get_tree().change_scene_to_packed(JUGEMENT_SCENE)
