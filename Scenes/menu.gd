extends Control

@export var gamescene : PackedScene
@onready var option_panel: Panel = $CanvasLayer/MarginContainer/OptionPanel

signal _hi
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	AudioManager.PlayPipeUI()
	get_tree().change_scene_to_packed(gamescene)
	_hi.emit()


func _on_options_btn_pressed() -> void:
	
	AudioManager.PlayPipeUI()
	option_panel.show()


func _on_option_back_button_pressed() -> void:
	
	AudioManager.PlayPipeUI()
	option_panel.hide()
