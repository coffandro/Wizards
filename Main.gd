extends Node

func _ready():
	$UserInterface/SettingsBackground.hide()

# Buttons
func _on_QuitButton_pressed():
	get_tree().quit()

func _on_SettingsButton_pressed():
	$UserInterface/SettingsBackground.show()


func _on_ReturnButton_pressed():
	$UserInterface/SettingsBackground.hide()
