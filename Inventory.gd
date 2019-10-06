extends PanelContainer

onready var list = find_node("InventoryList")
onready var item_icon = find_node("ItemIcon")
onready var item_name = find_node("ItemName")
onready var item_description = find_node("ItemDescription")

onready var snd_pickup : AudioStreamPlayer = find_node("Pickup")
onready var snd_place : AudioStreamPlayer = find_node("Place")
onready var snd_error : AudioStreamPlayer = find_node("Error")
onready var snd_switch : AudioStreamPlayer = find_node("Switch")

onready var player : KinematicBody2D = get_node("/root").find_node("Player", true, false)
onready var main = get_node("/root").find_node("Main", true, false)

var raw_items = []

func _ready():
	visible = true

func size():
	return raw_items.size()

func add_item(item):
	snd_pickup.play()
	raw_items.append(item)
	list.add_item(item.name, item.get_texture())
	list.set_item_tooltip(list.get_item_count()-1, item.description)
	if list.get_item_count() == 1:
		select_item(0)

func remove_item(idx):
	list.remove_item(idx)
	raw_items.remove(idx)
	if size() > 0:
		select_item(clamp(idx, 0, size()-1))

func get_item(idx):
	return raw_items[idx]

func use_item(idx):
	var item = get_item(idx)
	if player.get_room():
		if player.get_room().name == item.room_node.name:
			item.room_node.found_item(item)
			snd_place.play()
			main.apply_item(item)
			remove_item(idx)
		else:
			main.wrong_item(item)
			snd_error.play()
	else:
		snd_error.play()

func get_current_index():
	return list.get_selected_items()[0]

func remove_selected():
	if size() > 0:
		remove_item(get_current_index())

func get_selected():
	if size() > 0:
		return get_item(get_current_index())

func use_selected():
	if size() > 0:
		use_item(get_current_index())

func select_next():
	if size() > 0:
		select_item((get_current_index()+1) % size())

func select_prev():
	if size() > 0:
		select_item((get_current_index()+size()-1) % size())

func select_item(idx):
	snd_switch.play()
	list.select(idx)
	list.ensure_current_is_visible()
	item_icon.texture = raw_items[idx].get_texture()
	item_name.text = raw_items[idx].name
	item_description.text = raw_items[idx].description

func unfocus():
	list.release_focus()

func _unhandled_input(event):
	if event.is_action_pressed("item_next"):
		select_next()
	if event.is_action_pressed("item_previous"):
		select_prev()
	if event.is_action_pressed("item_activate"):
		use_selected()

func _on_InventoryList_nothing_selected():
	if size() > 0:
		select_item(0)

func _on_InventoryList_item_activated(index):
	use_item(index)

func _on_InventoryList_item_selected(index):
	select_item(index)

func _on_Use_pressed():
	use_selected()
