extends Area3D
class_name GaugeObject

signal pressure_fixed
var isMouseHovering: bool
var isPlaying: bool
var isActive: bool
var target = deg_to_rad(-30.0)
var reset_target = deg_to_rad(125)
var SPEED = 1
var cd_time: int
@onready var phantom_camera_3d: PhantomCamera3D = $PhantomCamera3D
@onready var pressure_needle: Node3D = $Pressure_Gauge/Pressure_Needle
@onready var cd_timer: Timer = $CDTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cd_time = randi_range(5, 10)
	phantom_camera_3d.priority = 0
	cd_timer.wait_time = cd_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isActive:
		var current_rot = pressure_needle.rotation
		current_rot.z = lerp_angle(current_rot.z, target, SPEED * delta)
		pressure_needle.rotation = current_rot
		if abs(current_rot.z - target) < 0.1:
			isPlaying = true
			
	

func RestartTimer() -> void:
	if cd_timer.is_stopped():
		cd_timer.start()
		SPEED = 1

func _mouse_enter() -> void:
	isMouseHovering = true

func _mouse_exit() -> void:
	isMouseHovering = false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick") == true and isActive and isMouseHovering == true:
		if isPlaying:
			print("Clicked on Guage")
			phantom_camera_3d.priority = 2
		else:
			print("Reducing Pressure")
			pressure_needle.rotation.z = pressure_needle.rotation.z - 50
			SPEED -= 0.01
			if SPEED <= 0.6:
				isActive = false
				isPlaying = false
				RestartTimer()
				phantom_camera_3d.priority = 0
				SPEED = 1
				isPlaying = false
				


func _on_cd_timer_timeout() -> void:
	isActive = true
