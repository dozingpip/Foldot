extends MeshInstance

var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
var color = Color(0.9, 0.1, 0.1)
var points = []

var Point = load("res://Point.gd")
var Fold = load("res://Fold.gd")

var interpolating = false
var interpolate_speed = 0.2
var has_target

var start_fold
var target_fold

var current_mesh
var target_mesh

var current_mesh_data
var target_mesh_data

var start_num_vertices = 0
var target_num_vertices = 0

func _init(_fold_start_file, _fold_end_file=null):
	start_fold = Fold.new(_fold_start_file)
	if _fold_end_file != null:
		has_target = true
		target_fold = Fold.new(_fold_end_file)
	pass

func _ready():
	current_mesh_data = MeshDataTool.new()
	current_mesh = generate_mesh(start_fold)
	name = start_fold.file_name
	current_mesh_data.create_from_surface(current_mesh, 0)
	start_num_vertices = current_mesh_data.get_vertex_count()
	
	if has_target:
		target_mesh_data = MeshDataTool.new()
		
		target_mesh = generate_mesh(target_fold)
		
		target_mesh_data.create_from_surface(target_mesh, 0)
		target_num_vertices = target_mesh_data.get_vertex_count()
		start_interpolation()
	
	highlight_points()
	mesh = current_mesh
	pass

func generate_mesh(_fold):
	var st = SurfaceTool.new()
	st.begin(ArrayMesh.PRIMITIVE_TRIANGLES)
	for face in _fold.faces_vertices:
		if(face.size()==3):
			var vc = _fold.vertices_coords
			st.add_vertex( Vector3( vc[face[2] ][0], vc[face[2] ][1], vc[face[2] ][2] ))
			st.add_vertex( Vector3( vc[face[1] ][0], vc[face[1] ][1], vc[face[1] ][2] ))
			st.add_vertex( Vector3( vc[face[0] ][0], vc[face[0] ][1], vc[face[0] ][2] ))
	
#			st.add_vertex( Vector3( vc[face[0] ][0], vc[face[0] ][1], vc[face[0] ][2] ))
#			st.add_vertex( Vector3( vc[face[1] ][0], vc[face[1] ][1], vc[face[1] ][2] ))
#			st.add_vertex( Vector3( vc[face[2] ][0], vc[face[2] ][1], vc[face[2] ][2] ))
		else:
			print("too many vertices along one face, should be 3.")

	st.generate_normals()
	st.index()
	var tmpMesh = st.commit()
	
	return tmpMesh

func highlight_point(_index):
	var position = current_mesh_data.get_vertex(_index)
	var point_object = Point.new(position, _index)
	add_child(point_object)
	return point_object

func highlight_points():
	for i in range(current_mesh_data.get_vertex_count()):
		points.append(highlight_point(i))
	
	for edge in start_fold.edges_vertices:
		points[edge[0]].new_connection(points[edge[1]])
	pass

func _process(delta):
	if(interpolating):
		interpolate(delta)
		mesh = current_mesh

func start_interpolation():
	if target_num_vertices == start_num_vertices:
		interpolating = true
	else:
		print("i: "+str(target_num_vertices) + " and v: "+ str(start_num_vertices)+", so can't interpolate, not same number of vertices")

func interpolate(delta):
	var interpolated_count = 0
	for i in range(start_num_vertices):
		var goal_vertex = target_mesh_data.get_vertex(i)
		var vertex = current_mesh_data.get_vertex(i)
		if vertex.distance_to(goal_vertex)>interpolate_speed:
			
			var move_amount = interpolate_speed*delta
			
			vertex.x += (move_amount if goal_vertex.x > vertex.x else -move_amount)
			vertex.y += (move_amount if goal_vertex.y > vertex.y else -move_amount)
			vertex.z += (move_amount if goal_vertex.z > vertex.z else -move_amount)
			
			current_mesh_data.set_vertex(i, vertex)
		else:
			interpolated_count += 1
			current_mesh_data.set_vertex(i, goal_vertex)
		
		if interpolated_count>=start_num_vertices:
			interpolating = false
			print("finished interpolation")
	current_mesh.surface_remove(0)
	current_mesh_data.commit_to_surface(current_mesh)
	
	if(!interpolating):
		var st = SurfaceTool.new()
		st.begin(ArrayMesh.PRIMITIVE_TRIANGLES)
		st.create_from(current_mesh, 0)
		st.generate_normals()
		st.index()
		current_mesh = st.commit()
	pass