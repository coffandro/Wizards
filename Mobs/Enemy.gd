extends CharacterBody3D

signal hit

var run_speed = 2.5
var player = null

func _physics_process(_delta):
	if player:
		velocity = transform.origin.direction_to(player.transform.origin) * run_speed
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func _on_DetectRadius_body_entered(body):
	player = body

func _on_DetectRadius_body_exited(body):
	player = null

func _on_exploded():
	queue_free()

func _on_collision_body_entered(body):
	if body.is_in_group("Player"):
		body.hit()
