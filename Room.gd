extends Node2D

onready var player : KinematicBody = get_node("/root").find_node("Player", true, false)
onready var description_label : Label = get_node("/root").find_node("RoomDescription", true, false)
onready var particles : CPUParticles2D = find_node("Particles")
onready var sound : CPUParticles2D = find_node("Sound")
var outstanding_items = 0

export(String, MULTILINE) var description = "I perceive nothing but a gaping void here."

func _ready():
	particles.rotate(particles.global_position.angle_to_point(Vector2(0, 0)) + PI)

func found_item(item):
	outstanding_items -= 1
	if outstanding_items == 0:
		sound.play()
		particles.visible = true

func _on_Area2D_body_entered(body):
	player.room = self
	description_label.text = description
	description_label.get_parent().visible = true


func _on_Area2D_body_exited(body):
	player.room = null
	description_label.get_parent().visible = false
	description_label.text = ""
