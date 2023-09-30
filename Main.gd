extends Node

onready var global = get_node("/root/Global")

var enemies

func _ready():
	$UserInterface/WinScreen.hide()
	$UserInterface/DeathScreen.hide()

func _process(delta):
	$UserInterface/ProgressBar.value = global.Playerhealth

func _on_FinishArea_body_entered(body):
	if body.is_in_group("Player"):
		global.PlayerDead = true
		$Player.hide()
		$UserInterface/WinScreen.show()

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()


func _on_Player_PlayerDied():
	enemies = get_tree().get_nodes_in_group("Enemy")
	for i in enemies:
		i.queue_free()
	$Player.hide()
	$UserInterface/DeathScreen.show()
