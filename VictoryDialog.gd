extends CenterContainer

onready var title_button : Button = find_node("Title")
onready var exit_button : Button = find_node("Exit")
onready var sound : AudioStreamPlayer = find_node("Sound")

func _ready():
	visible = false

func activate():
	sound.play()
	visible = true
	title_button.grab_focus()
	get_tree().paused = true

func _on_Exit_pressed():
	if OS.get_name() == "HTML5":
		#can't actually exit on HTML5, so return to title
		get_tree().change_scene("res://TitleScreen.tscn")
	else:
		get_tree().quit()


func _on_Title_pressed():
		get_tree().change_scene("res://TitleScreen.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if visible:
			_on_Title_pressed()
