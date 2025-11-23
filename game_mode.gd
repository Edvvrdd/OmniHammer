extends Node

class_name PipeGameMode

@export var all_pipes : Array[PipeObject]
@export var all_gauges : Array[GaugeObject]
@export var timeBetweenLeaks_start : float = 10
@export var timeBetweenLeaks_ramp : float = 0.8
@export var timeBetweenLeaks_min : float = 1
@export var num_leaksAtOnce : int = 1
var timer : Timer
var timeBetweenLeaks_Current : float
var isTimerActive : bool = false
@onready var leak_loop_sfx: AudioStreamPlayer3D = $"../Pipes/LeakLoopSFX"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(0, all_pipes.size()):
		all_pipes[i].Hide_PipeHitbox()
		all_pipes[i].pipe_fixed.connect(PipeFixed_Callback)
	
	timeBetweenLeaks_Current = timeBetweenLeaks_start
	Timer_Start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isTimerActive == true:
		timeBetweenLeaks_Current -= delta
		if timeBetweenLeaks_Current <= 0:
			print("Activate leak")
			for i in range(0, num_leaksAtOnce):
				var pipe = all_pipes.pick_random()
				pipe.PickMinigame()
				leak_loop_sfx.play()
				pipe.Show_PipeHitbox()
			
			timeBetweenLeaks_start = timeBetweenLeaks_start * timeBetweenLeaks_ramp
			timeBetweenLeaks_Current = max(timeBetweenLeaks_start, timeBetweenLeaks_min)

func Timer_Start() -> void:
	isTimerActive = true

func PipeFixed_Callback() -> void:
	leak_loop_sfx.stop()
	pass
	#TODO ZOOM CAMERA OUT
