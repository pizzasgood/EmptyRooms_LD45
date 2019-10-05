extends KinematicBody2D

const max_speed = 200

var vel = Vector2()
var active = true
var room

onready var main = get_node("/root").find_node("Main", true, false)
onready var inventory : GridContainer = get_node("/root").find_node("Inventory", true, false)

func _ready():
	pass

func _process(delta):
	find_node("Sprite").self_modulate = Color(1, 1, 1, float(main.max_failures - main.failures) / main.max_failures)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	vel = Vector2()
	if active:
		if Input.is_action_pressed("movement_up"):
			vel.y -= 1
		if Input.is_action_pressed("movement_down"):
			vel.y += 1
		if Input.is_action_pressed("movement_left"):
			vel.x -= 1
		if Input.is_action_pressed("movement_right"):
			vel.x += 1
		vel = max_speed * vel.clamped(1)

func process_movement(delta):
	move_and_slide(vel)

func add_item(item):
	inventory.add_item(item)

func get_room():
	return room