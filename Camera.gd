extends Camera

var speed = 0.5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_left"):
		translate(Vector3(-speed, 0, 0))
		rotate_y(0.1)
	if Input.is_action_pressed("ui_right"):
		translate(Vector3(speed, 0, 0))
		rotate_y(-0.1)
	if Input.is_action_pressed("ui_up"):
		translate(Vector3(0, speed, 0))
		rotate_x(0.1)
	if Input.is_action_pressed("ui_down"):
		translate(Vector3(0, -speed, 0))
		rotate_x(-0.1)
	pass
