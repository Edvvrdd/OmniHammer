extends Node3D

@export var GameScene: PackedScene
@export var CamTarget: PhantomCamera3D
@export var time_in_seconds : int
@onready var TV : AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TV.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("MouseClick"):
		CamTarget.priority = 3
		await get_tree().create_timer(time_in_seconds).timeout
		get_tree().change_scene_to_packed(GameScene)
		AudioManager.SwitchToGameMx()
