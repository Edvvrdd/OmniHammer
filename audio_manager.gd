extends Node

@onready var pipe_ui: AudioStreamPlayer = $PipeUI
@onready var mx: AudioStreamPlayer = $Mx
@onready var tv: AudioStreamPlayer = $Tv

func _ready() -> void:
	mx.play()

func PlayPipeUI() -> void:
	pipe_ui.play()
	
func SwitchToGameMx() -> void:
	mx.set("parameters/switch_to_clip", "Start")

func StopMx() -> void:
	mx.stop()
