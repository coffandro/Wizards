extends KinematicBody

var navAgent : NavigationAgent

var health = 10

onready var global = get_node("/root/Global")

onready var Bullet = load("res://Weapons/EBullet.tscn")

var Presence = false

func _ready():
	navAgent = $NavigationAgent
	navAgent.connect("velocity_computed", self, "_on_velocity_computed")

func hit():
	health -= 1
	if health < 0:
		queue_free()

func _physics_process(delta):
	if Presence == true:
		if navAgent.is_navigation_finished():
			return
		var targetPos = navAgent.get_next_location()
		var direction = global_transform.origin.direction_to(targetPos)
		var velocity = direction * navAgent.max_speed
		look_at(targetPos, Vector3.UP)
		self.rotate_object_local(Vector3.UP, 3.14)
		navAgent.set_velocity(velocity)

func _on_velocity_computed(velocity):
	move_and_slide(velocity, Vector3.UP)

func _on_Timer_timeout():
	if Presence == true:
		if global.PlayerDead == false:
			navAgent.set_target_location(get_tree().get_nodes_in_group("Player")[0].global_transform.origin)

func _on_ShootArea_body_entered(body):
	if $CooldownTimer.is_stopped():
		if body.is_in_group("Player"):
			var b = Bullet.instance()
			owner.add_child(b)
			b.transform = $Pivot/Shoot.global_transform
			b.velocity = b.transform.basis.z * b.muzzle_velocity
			$CooldownTimer.start()

func Spotted():
	Presence = true
