extends Node2D

onready var background = find_node("Background")
onready var sprite = find_node("Sprite")
onready var anim = find_node("AnimationPlayer")
onready var timer = find_node("Timer")
onready var player = get_node("/root").find_node("Player", true, false)
onready var victory_dialog = get_node("/root").find_node("VictoryDialog", true, false)

var victory = false

func _ready():
	background.visible = false
	sprite.visible = false

func start():
	victory = true
	sprite.visible = true

func _on_Area2D_body_entered(body):
	if victory == true:
		background.visible = true
		player.active = false
		player.visible = false
		anim.stop()
		anim.clear_queue()
		anim.play("finale")
		timer.start()

func _on_Timer_timeout():
	victory_dialog.activate()