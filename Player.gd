extends KinematicBody

export var PlayerSpeed = 8
export var SpeedBoost = 1

export var fall_acceleration = 75
export var jump_impulse = 20

var velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	
	if Input.is_action_pressed("sprint"):
		SpeedBoost = 2
	else:
		SpeedBoost = 1
	
	if Input.is_action_just_pressed("attack"):
		print("attack")
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	velocity.x = direction.x * PlayerSpeed * SpeedBoost
	velocity.z = direction.z * PlayerSpeed * SpeedBoost
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
