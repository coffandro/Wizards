extends Node

@export var enemyScene: PackedScene

var EnemyNumber = 200

#func _ready():
	#for i in EnemyNumber:
		#randomize()
		#var enemy = enemyScene.instantiate()
		#enemy.transform.origin = Vector3(randf_range(-7, 7), 1, randf_range(-7, 7))
		#add_child(enemy)
