extends Control
@export var Niveau1: PackedScene

func on_texture_button_play_pressed():
	get_tree().change_scene_to_packed(Niveau1)

func on_texture_button_option_pressed():
	pass

func on_texture_button_quit_pressed():
	get_tree().quit()
