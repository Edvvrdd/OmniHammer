extends Area3D
class_name GaugeObject

signal pressure_fixed
var isMouseHovering: bool
@onready var phantom_camera_3d: PhantomCamera3D = $PhantomCamera3D

@onready var pressure_needle: Node3D = $Pressure_Gauge/Pressure_Needle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	phantom_camera_3d.priority = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#pressure_needle.rotate(Vector3(0,0,1), -1 * delta)
	pass

func _mouse_enter() -> void:
	isMouseHovering = true

func _mouse_exit() -> void:
	isMouseHovering = false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick") == true and isMouseHovering == true:
		print("Clicked on Guage")
