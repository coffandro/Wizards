extends KinematicBody

export var PlayerSpeed = 8
export var SpeedBoost = 1

export var fall_acceleration = 75
export var jump_impulse = 20

export (PackedScene) var Bullet

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
	
	if Input.is_action_pressed("sprint"):
		SpeedBoost = 1.5
	else:
		SpeedBoost = 1
	
	if Input.is_action_just_pressed("attack") and $CooldownTimer.is_stopped():
		print("attack")
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $Pivot/Shoot.global_transform
		b.velocity = -b.transform.basis.z * b.muzzle_velocity
		$CooldownTimer.start()
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	velocity.x = direction.x * PlayerSpeed * SpeedBoost
	velocity.z = direction.z * PlayerSpeed * SpeedBoost
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
