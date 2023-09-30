extends Area

signal exploded

export var muzzle_velocity = 25
export var g = Vector3.DOWN * 20

var velocity = Vector3.ZERO


func _physics_process(delta):
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta


func _on_Bullet_body_entered(body):
	if body.is_in_group("Player"):
		print("hit")
		body.hit()
	print("miss")
	emit_signal("exploded", transform.origin)
	queue_free()
