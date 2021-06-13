extends Node

var playing_music: AudioStreamPlayer

func play(audio: String, bus: String = "sound", audio_position: Vector2 = Vector2.ZERO):
	var audio_player: Node
	if audio_position != Vector2.ZERO:
		audio_player = AudioStreamPlayer2D.new()
		audio_player.position = audio_position
	else:
		audio_player = AudioStreamPlayer.new()

	audio_player.stream = load(audio)
	audio_player.bus = bus
	audio_player.autoplay = true
	audio_player.name = audio.split("/")[-1].split(".")[0]
	add_child(audio_player)

	if bus == "music":
		playing_music = audio_player

	yield(audio_player, "finished")

	if bus == "music":
		playing_music = null

	audio_player.queue_free()

func stop():
	if playing_music:
		playing_music.queue_free()
		playing_music = null

func pause(pause: bool):
	if playing_music:
		playing_music.stream_paused = pause
