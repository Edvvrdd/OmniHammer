extends Area3D

class_name ClickableSphere

signal sphere_clicked(targetPos)

var isMouseOver : bool = false
var isActive: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Hide_Clickable_Object() -> void:
	self.hide()
	print("Hiding: "+self.name)

func Activate_Clickable_Object() -> void:
	print("Activating: "+self.name)
	isActive = true
	self.show()

func _mouse_enter() -> void:
	isMouseOver = true

func _mouse_exit() -> void:
	isMouseOver = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick") == true and isMouseOver == true:
		self.hide()
		sphere_clicked.emit(self, self.global_position)

func GetActive() -> bool:
	return isActive
