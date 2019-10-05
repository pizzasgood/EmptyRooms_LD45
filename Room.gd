extends Node2D

var description_label : RichTextLabel

export(String, MULTILINE) var description = "I perceive nothing but a gaping void here."

func _ready():
	print(get_node("/root"))
	description_label = get_node("/root").find_node("RoomDescription", true, false)


func _on_Area2D_body_entered(body):
	description_label.bbcode_text = description


func _on_Area2D_body_exited(body):
	description_label.clear()
