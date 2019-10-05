extends Node2D

onready var player : KinematicBody = get_node("/root").find_node("Player", true, false)
onready var description_label : Label = get_node("/root").find_node("RoomDescription", true, false)

export(String, MULTILINE) var description = "I perceive nothing but a gaping void here."

func _ready():
	pass


func _on_Area2D_body_entered(body):
	player.room = self
	description_label.text = description
	description_label.get_parent().visible = true


func _on_Area2D_body_exited(body):
	player.room = null
	description_label.get_parent().visible = false
	description_label.text = ""
