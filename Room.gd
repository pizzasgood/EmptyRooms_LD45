extends Node2D

var description_label : Label

export(String, MULTILINE) var description = "I perceive nothing but a gaping void here."

func _ready():
	description_label = get_node("/root").find_node("RoomDescription", true, false)


func _on_Area2D_body_entered(body):
	description_label.text = description
	description_label.get_parent().visible = true


func _on_Area2D_body_exited(body):
	description_label.get_parent().visible = false
	description_label.text = ""
