extends Node

export (PackedScene) var enemy_scene

var EnemyNumber = 3

func _ready():
	for i in EnemyNumber:
		randomize()
		var enemy = enemy_scene.instance()
		enemy.transform.origin = Vector3(rand_range(-7, 7), 1, rand_range(-7, 7))
		add_child(enemy)
