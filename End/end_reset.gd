extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var Menu : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.StopMx()
	audio_stream_player.play(0)
	


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(Menu)
