extends Label

onready var global = get_node("/root/Global")

func _on_EasterTimer_timeout():
	get_tree().change_scene("res://Main.tscn")
