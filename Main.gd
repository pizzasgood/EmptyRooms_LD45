extends Node

onready var hospital = get_node("/root").find_node("Hospital", true, false)
onready var failure = get_node("/root").find_node("FailureDialog", true, false)
onready var inventory : GridContainer = get_node("/root").find_node("Inventory", true, false)
onready var player = get_node("/root").find_node("Player", true, false)
onready var total_item_count = get_tree().get_nodes_in_group("Items").size()
var items_applied = 0
var failures = 5
var max_failures = 10

func _ready():
	pass

func apply_item(item):
	items_applied += 1
	failures = clamp(failures - 1, 0, max_failures)
	player.play("yay")
	if items_applied == total_item_count:
		hospital.start()

func wrong_item(item):
	failures += 1
	player.play("oops")
	if failures >= max_failures:
		failure.activate()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		inventory.unfocus()
