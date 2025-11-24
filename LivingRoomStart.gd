extends Node3D

var GameScene = preload("res://GameModeAlpha.tscn")
@export var CamTarget: PhantomCamera3D
@export var time_in_seconds : int
@onready var TV : AudioStreamPlayer = $AudioStreamPlayer
@onready var credit: PhantomCamera3D = $Credit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TV.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("MouseClick"):
		CamTarget.priority = 5
		await get_tree().create_timer(time_in_seconds).timeout
		get_tree().change_scene_to_packed(GameScene)
		AudioManager.SwitchToGameMx()


func _on_credit_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("MouseClick"):
		if credit.priority == 0:
			credit.priority = 3
		else:
			credit.priority = 0
