extends Node3D

@export var gamemode : PipeGameMode
@export var waterpos_Start : Vector3
@export var waterpos_End : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var offset = waterpos_End.y - waterpos_Start.y
	var offsetPercent = gamemode.totalFloodProgress / 60
	offset = offset * offsetPercent
	
	self.position.y = self.waterpos_Start.y + offset
