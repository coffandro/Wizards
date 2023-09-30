extends KinematicBody

export var PlayerSpeed = 8
export var SpeedBoost = 1
var velocity = Vector3.ZERO

onready var global = get_node("/root/Global")
onready var camera = $CameraPath/Camera

var cursorShoot = load("res://assets/Cursor-Shoot.png")
var cursorX = load("res://assets/Cursor_X.png")

signal PlayerDied

export (PackedScene) var Bullet

func _physics_process(_delta):
	var direction = Vector3.ZERO
	if global.PlayerDead == false:
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_back"):
			direction.z += 1
		if Input.is_action_pressed("move_forward"):
			direction.z -= 1
	
		if Input.is_action_pressed("sprint"):
			SpeedBoost = 2
			$Pivot/RunningParticles.set_emitting(true)
			#if global.keyb == true:
			Input.set_custom_mouse_cursor(cursorX)
		else:
			SpeedBoost = 1
			$Pivot/RunningParticles.set_emitting(false)
			#if global.keyb == true:
			Input.set_custom_mouse_cursor(cursorShoot)
	
		if Input.is_action_just_pressed("attack") and $CooldownTimer.is_stopped() and not Input.is_action_pressed("sprint"):
			var b = Bullet.instance()
			owner.add_child(b)
			b.transform = $ShootPivot/Shoot.global_transform
			b.velocity = -b.transform.basis.z * b.muzzle_velocity
			$CooldownTimer.start()
	
	#if global.keyb == false:
		#print("joy")
	#else:
	look_at_cursor()
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	velocity.x = direction.x * PlayerSpeed * SpeedBoost
	velocity.z = direction.z * PlayerSpeed * SpeedBoost
	velocity = move_and_slide(velocity, Vector3.UP)
	

func look_at_cursor():
	# Create a horizontal plane, and find a point where the ray intersects with it
	var player_pos = $Pivot.global_transform.origin
	var dropPlane  = Plane(Vector3(0, 1, 0), player_pos.y)
	# Project a ray from camera, from where the mouse cursor is in 2D viewport
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = dropPlane.intersects_ray(from,to)
	
	# Set the position of cursor visualizer
	#cursor.global_transform.origin = cursor_pos + Vector3(0,1,0)
	
	# Make player look at the cursor
	$ShootPivot.look_at(cursor_pos, Vector3.UP)

func hit():
	global.Playerhealth -= 1
	if global.Playerhealth < 1:
		global.PlayerDead = true
		emit_signal("PlayerDied")
	print("Player hit")

#func rslook():
#	rs_look.y = Input.get_joy_axis(0, JOY_AXIS_3)
#	rs_look.x = Input.get_joy_axis(0, JOY_AXIS_2)
#	$ShootPivot.rotation = rs_look.angle()


func _on_EnemyTrigger_body_entered(body):
	if body.is_in_group("Enemy"):
		print("Spotted")
		body.Spotted()
