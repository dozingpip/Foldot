extends Spatial

var speed = 0.5
var model
export var fold_file = "flappingBird"
export var flat_fold = "flappingBirdFlat"
export var material = "res://materials/test_material.tres"
signal create_model(flat_fold, fold_file, material)
signal created_model

func _init():
	emit_signal("create_model")
	print("emitted signal")
	self.connect("created_model", self, "_on_ModelManager_created_model")
	pass

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("ui_left"):
		translate(Vector3(-speed, 0, 0))
		#rotate_y(0.1)
	if Input.is_action_pressed("ui_right"):
		translate(Vector3(speed, 0, 0))
		#rotate_y(-0.1)
	if Input.is_action_pressed("ui_up"):
		translate(Vector3(0, speed, 0))
		#rotate_x(0.1)
	if Input.is_action_pressed("ui_down"):
		translate(Vector3(0, -speed, 0))
		#rotate_x(-0.1)
	pass

func _on_ModelManager_created_model(_model):
	model = _model
	add_child(model)
