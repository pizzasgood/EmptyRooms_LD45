extends Node

onready var victory = get_node("/root").find_node("VictoryDialog", true, false)
onready var failure = get_node("/root").find_node("FailureDialog", true, false)
onready var total_item_count = get_tree().get_nodes_in_group("Items").size()
var items_applied = 0
var failures = 5
var max_failures = 10

func _ready():
	pass

func apply_item(item):
	items_applied += 1
	failures = clamp(failures - 1, 0, max_failures)
	if items_applied == total_item_count:
		victory.activate()

func wrong_item(item):
	failures += 1
	if failures >= max_failures:
		failure.activate()