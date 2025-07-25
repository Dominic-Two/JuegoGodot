extends Camera3D

func _process(delta):
	look_at(Vector3(0, 1, 0), Vector3.UP)
