extends CharacterBody3D

@export var PlayerSpeed = 8
@export var SpeedBoost = 1

@export var fall_acceleration = 75
@export var jump_impulse = 20

@export var Bullet: PackedScene

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
	
	if Input.is_action_pressed("sprint") and direction != Vector3.ZERO:
		SpeedBoost = 2
		$Pivot/RunningParticles.set_emitting(true)
	else:
		SpeedBoost = 1
		$Pivot/RunningParticles.set_emitting(false)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_impulse
	
	if Input.is_action_just_pressed("attack") and $CooldownTimer.is_stopped() and not Input.is_action_pressed("sprint"):
		print("attack")
		var b = Bullet.instantiate()
		owner.add_child(b)
		b.transform = $Pivot/Shoot.global_transform
		b.velocity = -b.transform.basis.z * b.muzzle_velocity
		$CooldownTimer.start()
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	
	velocity.x = direction.x * PlayerSpeed * SpeedBoost
	velocity.z = direction.z * PlayerSpeed * SpeedBoost
	velocity.y -= fall_acceleration * delta
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity

func hit():
	queue_free()
