extends Area3D

class_name PipeObject

signal pipe_fixed

enum pipe_states {
	NEW,
	DETERIORATED,
	BROKEN
}
var state : pipe_states = pipe_states.NEW

enum pipe_type {
	STRAIGHT,
	CORNER,
}
@export var pipe_type_to_use : pipe_type = pipe_type.STRAIGHT
@onready var phantom_camera_3d = $PhantomCamera3D

var isFocus : bool = false
var isMouseHovering : bool = false
var isBroken: bool = false

@export var all_clickable_objs : Array[ClickableSphere] 
var num_leaks_fixed : int = 0
var num_leaks_sprung : int = 0
var num_leaks_actually_sprung: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phantom_camera_3d.priority = 0
	Hide_PipeHitbox()
	TogglePipeHitbox(false)
	
	if pipe_type_to_use == pipe_type.STRAIGHT:
		$Pipe_Straight.show()
		$Pipe_Corner.hide()
	if pipe_type_to_use == pipe_type.CORNER:
		$Pipe_Straight.hide()
		$Pipe_Corner.show()
	
	#hides all leak spots
	for i in range(0, all_clickable_objs.size()):
		all_clickable_objs[i].sphere_clicked.connect(Sphere_Clicked_Callback)
		all_clickable_objs[i].Hide_Clickable_Object()

func TogglePipeHitbox(on: bool) -> void:
	$pipe_hitbox.disabled = on
	
func Hide_PipeHitbox() -> void:
	$pipe_hitbox.hide()

func Show_PipeHitbox() -> void:
	$pipe_hitbox.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func PickMinigame() -> void:
	if isBroken:
		return
	else:
		isBroken = true
	TogglePipeHitbox(false)
	#resets clickable sphere
	num_leaks_fixed = 0
	num_leaks_actually_sprung = 0
	
	#pick random spheres to activate
	num_leaks_sprung = randi_range(1, all_clickable_objs.size())
	
	for i in range(0, num_leaks_sprung):
		var clickable_leak_obj = all_clickable_objs.pick_random()
		if !clickable_leak_obj.GetActive():
			clickable_leak_obj.Activate_Clickable_Object()
			num_leaks_actually_sprung += 1

func Sphere_Clicked_Callback(_sphere : ClickableSphere, targetPos : Vector3) -> void:
	
	num_leaks_fixed += 1
	IsMinigameComplete()

func IsMinigameComplete() -> void:
	if num_leaks_fixed >= num_leaks_actually_sprung:
		pipe_fixed.emit()
		isBroken = false
		phantom_camera_3d.priority = 0
		print("FIXED")

func _mouse_enter() -> void:
	isMouseHovering = true

func _mouse_exit() -> void:
	isMouseHovering = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick") == true and isMouseHovering == true:
		print("Clicked on pipe")
		if isBroken:
			phantom_camera_3d.priority = 2
			TogglePipeHitbox(true)
		#TODO ZOOM CAMERA IN (THIS ISN'T WORKING)
