extends KinematicBody

var run_speed = 2.5
var velocity = Vector3.ZERO
var player = null

func _physics_process(_delta):
	velocity = Vector3.ZERO
	if player:
		velocity = transform.origin.direction_to(player.transform.origin) * run_speed
	velocity = move_and_slide(velocity)

func _on_DetectRadius_body_entered(body):
	player = body

func _on_DetectRadius_body_exited(body):
	player = null
