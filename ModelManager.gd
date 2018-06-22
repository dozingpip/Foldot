extends Node

var Model = load("res://Model.gd")
var model
signal created_model(model)
signal create_model

func _ready():
	self.connect("create_model", self, "model_fold")

func model_fold(_start_fold_file, _target_fold_file=null, _material="res://materials/test_material.tres"):
	print("received signal")
	print("starting model creation")
	
	model = Model.new(_start_fold_file, _target_fold_file, _material)
	
	print("finished model creation")
	emit_signal("created_model")
