extends Node

@onready var pipe_ui: AudioStreamPlayer = $PipeUI

func PlayPipeUI() -> void:
	pipe_ui.play()
