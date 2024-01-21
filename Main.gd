extends Node

@export var enemyScene: PackedScene

@export var EnemyNumber = 10
@export var EnemySpawnRange1 = 10
@export var EnemySpawnRange2 = -10

func _ready():
	for i in EnemyNumber:
		randomize()
		var enemy = enemyScene.instantiate()
		enemy.transform.origin = Vector3(randf_range(EnemySpawnRange2, EnemySpawnRange1), 1, randf_range(EnemySpawnRange2, EnemySpawnRange1))
		add_child(enemy)
