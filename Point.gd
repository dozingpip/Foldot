extends MeshInstance

var connections = []
var Line = load("res://Line.gd")
var index = -1

func _init(_position, _index):
	set_translation(_position)
	index = _index
	name = "Vertex "+ str(index)
	
func new_connection(_connection):
	connections.append(_connection)

func position_changed(_new_pos):
	set_translation(_new_pos)
	
	for i in connections:
		var name = "line from "+ str(index) + " to "+ str(i.index)
		if hasNode(name):
			remove_child(name)
		var line = Line.new()
		line._init(translation, i.translation)