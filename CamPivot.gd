extends Spatial

func _physics_process(_delta):
	if Input.is_action_pressed("rotate_up"):
		rotate_object_local(Vector3(1, 0, 0), 0.05)
	if Input.is_action_pressed("rotate_down"):
		rotate_object_local(Vector3(1, 0, 0), -0.05)
	if Input.is_action_pressed("rotate_left"):
		rotate_y(0.05)
	if Input.is_action_pressed("rotate_right"):
		rotate_y(-0.05)
