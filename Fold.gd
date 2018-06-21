extends Node

var vertices_coords = []
var faces_vertices = []
var edges_vertices = []
var file_name
var dict={}

func _init(_file_name):
	file_name = _file_name
	var file = File.new()
	file.open("res://folds/"+file_name+".fold", file.READ) if file.file_exists("res://folds/"+file_name+".fold") else print("nu")
	var text = file.get_as_text()
	dict = parse_json(text)
	file.close()
	create_fold()

func create_fold():
	vertices_coords = dict["vertices_coords"];
	faces_vertices = dict["faces_vertices"];
	edges_vertices = dict["edges_vertices"];

func update_fold(_new_coords):
	vertices_coords = _new_coords;