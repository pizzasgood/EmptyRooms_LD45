extends Node2D

onready var sprite = find_node("Sprite")
onready var image : Sprite = get_node("/root").find_node("Img %s" % name, true, false)

export(String, MULTILINE) var description = "No idea what this thing is! ¯\\_(ツ)_/¯"

export(NodePath) var room

onready var room_node = get_node(room)

func _ready():
	room_node.outstanding_items += 1

func resolve():
	room_node.found_item(self)
	image.visible = true

func _on_Area2D_body_entered(body):
	if visible:
		visible = false
		body.add_item(self)

func get_texture():
	return sprite.texture