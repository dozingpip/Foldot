extends Node

var file_name = "flappingBird"
var interpolate_to_file_name = "flappingBirdFlat"
var fold_file_path = "folds"

var Model = load("res://Model.gd")
var a_model

# Use this for initialization
func _ready():
	print("starting model creation")
	
	a_model = Model.new(interpolate_to_file_name, file_name)
	add_child(a_model)
	
	print("finished model creation")