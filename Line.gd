extends MeshInstance

func _init(_point1, _point2):
	var between = _point2 - _point1
	var distance = between.length()
	scale = Vector3(0.5, 0.5, distance)
	set_translation(_point1 + between * 0.5)
	look_at(_point2)