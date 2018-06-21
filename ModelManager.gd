extends Node

export var fold_file = "flappingBird"
export var flat_fold = "flappingBirdFlat"
export var material = "res://materials/test_material.tres"
var fold_file_path = "folds"

var Model = load("res://Model.gd")
var a_model

# Use this for initialization
func _ready():
	a_model = model_fold(flat_fold, fold_file)
	add_child(a_model)
	pass
	
func model_fold(_start_fold_file, _target_fold_file=null, _material="res://materials/test_material.tres"):
	print("starting model creation")
	
	return Model.new(_start_fold_file, _target_fold_file, material)
	
	print("finished model creation")