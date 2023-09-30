extends KinematicBody2D

export (int) var speed = 200
var SpeedBoost = 1

onready var global = get_node("/root/Global")

var velocity = Vector2()
var direction = 0

func _physics_process(delta):
	velocity = Vector2()
	if global.Paused == false:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
			if SpeedBoost == 2:
				$AnimatedSprite.play("Run_Right")
			else:
				$AnimatedSprite.play("Walk_Right")
			direction = 3
		elif Input.is_action_pressed("move_left"):
			velocity.x -= 1
			if SpeedBoost == 2:
				$AnimatedSprite.play("Run_Left")
			else:
				$AnimatedSprite.play("Walk_Left")
			direction = 2
		elif Input.is_action_pressed("move_back"):
			velocity.y += 1
			if SpeedBoost == 2:
				$AnimatedSprite.play("Run_Down")
			else:
				$AnimatedSprite.play("Walk_Down")
			direction = 0
		elif Input.is_action_pressed("move_forward"):
			velocity.y -= 1
			if SpeedBoost == 2:
				$AnimatedSprite.play("Run_Up")
			else:
				$AnimatedSprite.play("Walk_Up")
			direction = 1
		else:
			if direction == 0:
				$AnimatedSprite.play("Stand_Down")
			if direction == 1:
				$AnimatedSprite.play("Stand_Up")
			if direction == 2:
				$AnimatedSprite.play("Stand_Left")
			if direction == 3:
				$AnimatedSprite.play("Stand_Right")
	
	if Input.is_action_pressed("sprint"):
		SpeedBoost = 2
	else:
		SpeedBoost = 1
	
	velocity = velocity.normalized() * speed * SpeedBoost
	velocity = move_and_slide(velocity)
