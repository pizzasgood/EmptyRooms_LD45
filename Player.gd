extends KinematicBody

const gravity = -9.81
var vel = Vector3()
const max_speed = 10
const jump_speed = 8
const accel = 5

var dir = Vector3()

const deaccel = 10
const max_slope_angle = 40

var camera
var head

var mouse_sensitivity = 0.05
var invert_horizontal = 1
var invert_vertical = 1

func _ready():
	camera = $Head/Camera
	head = $Head

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	#walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()
	var input_movement_vector = Vector2()
	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x

	#jumping
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = jump_speed

	#cursor capture
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * gravity

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= max_speed

	var cur_accel
	if dir.dot(hvel) > 0:
		cur_accel = accel
	else:
		cur_accel = deaccel

	hvel = hvel.linear_interpolate(target, cur_accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(max_slope_angle))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_x(deg2rad(event.relative.y * mouse_sensitivity * -1 * invert_vertical))
		self.rotate_y(deg2rad(event.relative.x * mouse_sensitivity * -1 * invert_horizontal))
		var camera_rot = head.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		head.rotation_degrees = camera_rot