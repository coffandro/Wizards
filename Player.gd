extends CharacterBody3D

@export var PlayerSpeed = 8
@export var SpeedBoost = 1

@export var FallAcceleration = 75
@export var JumpImpulse = 20
@export var CamdeaRayLength = 1000

@export var Bullet: PackedScene

func _input(event):
	# Get joysticks for switch layer on via Input.get_connected_joypads()
	if event is InputEventMouseMotion:
		var MousePosX = ScreenPointToRay().x
		var MousePosY = ScreenPointToRay().y
		$Pivot.look_at(Vector3(MousePosX, 1, MousePosY), Vector3.UP)

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
		velocity.y = JumpImpulse
	
	if Input.is_action_just_pressed("attack") and $CooldownTimer.is_stopped() and not Input.is_action_pressed("sprint"):
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
	velocity.y -= FallAcceleration * delta
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	velocity = velocity

func ScreenPointToRay():
	var spaceState = get_world_3d().direct_space_state

	var mousePos = get_viewport().get_mouse_position()
	var camera = get_node("Camera3D")
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd))
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()

func hit():
	queue_free()
