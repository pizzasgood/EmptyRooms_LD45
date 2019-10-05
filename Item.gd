extends Node2D

onready var sprite = find_node("Sprite")

export(String, MULTILINE) var description = "No idea what this thing is! ¯\\_(ツ)_/¯"

export(NodePath) var room

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if visible:
		visible = false
		body.add_item(self)

func get_texture():
	return sprite.texture