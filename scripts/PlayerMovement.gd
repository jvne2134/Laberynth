extends CharacterBody3D

@export var speed = 6
@export var jump_velocity = 4.5
@export var look_sensitivity = 0.002
@export var fovSetting = 90

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y = 0
var flag = false

@onready var camera:Camera3D = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var horizontal_velocity = Input.get_vector("move_left","move_right","move_forward","move_backward").normalized() * speed
	velocity = horizontal_velocity.x * global_transform.basis.x + horizontal_velocity.y * global_transform.basis.z
	if is_on_floor():
		velocity_y = 0
		if Input.is_action_just_pressed("jump"): velocity_y = jump_velocity
	else:
		velocity_y -= gravity * delta
	velocity.y = velocity_y
	move_and_slide()
	if Input.is_action_just_pressed("ui_cancel"): 
		get_tree().quit()
		flag = !flag
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE

func _input(event):
	if flag == false:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * look_sensitivity)
			camera.rotate_x(-event.relative.y * look_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
