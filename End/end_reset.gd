extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var Menu = preload("res://StartMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.StopMx()
	audio_stream_player.play(0)
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(Menu)
