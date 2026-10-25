extends Node2D

@onready var player : AudioStreamPlayer = $AudioStreamPlayer

const DEFAULT_VOLUME := 100

var muted: bool = false
var previous_volume := 1.0

func play_menu() -> void:
	player.stream = load("res://Assets/Music Loop/Music_Menu.ogg")
	player.play(0.0)

func play_choice() -> void:
	var from = player.get_playback_position() + AudioServer.get_time_since_last_mix()
	player.stream = load("res://Assets/Music Loop/Music_Choice.ogg")
	print("Track playing: Music_Choice.ogg from pos ", from)
	player.play(from)

func play_ending() -> void:
	var from = player.get_playback_position() + AudioServer.get_time_since_last_mix()
	player.stream = load("res://Assets/Music Loop/Music_Ending.ogg")
	player.play(from)

func play_collecte(level: int) -> void:
	var from = player.get_playback_position() + AudioServer.get_time_since_last_mix()
	var track
	if (level >= 10):
		track = "Music_Collecte_10"
	elif level < 1:
		level = 1
		track = "Music_Collecte_01"
		from = 0.0
	else:
		track = str("Music_Collecte_0", level)
	print("Track playing: ", track, ".ogg from pos ", from)
	player.stream = load(str("res://Assets/Music Loop/", track, ".ogg"))
	player.play(from)

func stop() -> void:
	player.stop()

func toggle_mute() -> bool:
	muted = !muted
	if muted:
		previous_volume = player.volume_linear
		player.volume_linear = 0.0
	else:
		player.volume_linear = previous_volume
	return muted

func set_volume(vol: float) -> void:
	vol = clampf(vol, 0.0, 100.0) / 100
	if muted:
		previous_volume = vol
	else:
		player.volume_linear = vol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_volume(DEFAULT_VOLUME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
