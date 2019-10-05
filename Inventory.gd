extends PanelContainer

onready var list = find_node("InventoryList")

var raw_items = []

func _ready():
	pass

func size():
	return raw_items.size()

func add_item(item):
	raw_items.append(item)
	list.add_item(item.name, item.get_texture())
	list.set_item_tooltip(list.get_item_count()-1, item.description)
	if list.get_item_count() == 1:
		list.select(0)

func remove_item(idx):
	list.remove_item(idx)
	raw_items.remove(idx)

func get_item(idx):
	return raw_items[idx]

func use_item(idx):
	print("Don't know how, dawg!")

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
		list.select((get_current_index()+1) % size())

func select_prev():
	if size() > 0:
		list.select((get_current_index()+size()-1) % size())

func _unhandled_input(event):
	if event.is_action_pressed("item_next"):
		select_next()
	if event.is_action_pressed("item_previous"):
		select_prev()
	if event.is_action_pressed("item_activate"):
		use_selected()

func _on_InventoryList_nothing_selected():
	if size() > 0:
		list.select(0)

func _on_InventoryList_item_activated(index):
	use_item(index)
