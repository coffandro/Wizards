extends Node2D

onready var global = get_node("/root/Global")

func _ready():
	$CavePopup.hide()

func _on_Cave_body_entered(body):
	if body.name == "Player2D":
		$Player2D.hide()
		$CavePopup.show()
		global.Paused = true


func _on_PlayButton_pressed():
	$CavePopup/ColorRect/ColorRect/Label.text = str("Cave Story ;)")
	$CavePopup/ColorRect/ColorRect/EasterTimer.start()
	global.Paused = false

func _on_ReturnButton_pressed():
	$CavePopup.hide()
	$Player2D.show()
	global.Paused = false
