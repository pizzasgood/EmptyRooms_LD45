extends Node

func _ready():
	get_tree().paused = false
	if OS.get_name() == "HTML5":
		find_node("Exit").visible = false
	find_node("Start").grab_focus()

func _on_Start_pressed():
		get_tree().change_scene("res://Main.tscn")


func _on_Exit_pressed():
	if OS.get_name() == "HTML5":
		#can't actually exit on HTML5, so return to title
		get_tree().change_scene("res://TitleScreen.tscn")
	else:
		get_tree().quit()


func _on_MusicToggle_toggled(button_pressed):
	pass # Replace with function body.
