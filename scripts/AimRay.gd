extends RayCast3D

@onready var prompt = $Prompt

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	prompt.text = " "
	if is_colliding():
		print("ola")
		prompt.text = "Presiona E para salir "
