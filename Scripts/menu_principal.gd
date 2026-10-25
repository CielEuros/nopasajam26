extends Control
@export var Niveau1: PackedScene

func _ready() -> void:
	%Volume.visible = false
	%VolumeSlider.value = BackgroundMusicPlayer.player.volume_linear * 100
	BackgroundMusicPlayer.play_menu()

func on_texture_button_play_pressed():
	get_tree().change_scene_to_packed(Niveau1)

func on_texture_button_option_pressed():
	var volume_percent = %VolumeSlider.value
	%Volume/VolumeLabel.text = str(volume_percent as int, "%")
	%Volume.visible = !%Volume.visible

func on_texture_button_quit_pressed():
	get_tree().quit()


func _on_sound_slider_drag_ended(value_changed: bool) -> void:
	var volume_percent = %VolumeSlider.value
	%Volume/VolumeLabel.text = str(volume_percent as int, "%")
	BackgroundMusicPlayer.set_volume(volume_percent)
