extends TileMapLayer

var ortho_piece_scene
var ortho_piece_instance
var diagon_piece_scene
var diagon_piece_instance
var dot_scene
var dot_instance
var piece_label
var m_c #mouse_coordinates
var current_piece
var modified_tiles
var all_tiles_coordinates
var all_tiles = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ortho_piece_scene = preload("res://scenes/ortho_piece.tscn")
	ortho_piece_instance = ortho_piece_scene.instantiate()
	diagon_piece_scene = preload("res://scenes/diagon_piece.tscn")
	diagon_piece_instance = diagon_piece_scene.instantiate()
	dot_scene = preload("res://scenes/dot.tscn")
	
	get_node("TileMapArea/TileMapCollisionShape").scale.x = scale.x
	get_node("TileMapArea/TileMapCollisionShape").scale.y = scale.y

	piece_label = get_node("PieceLabel")
	current_piece = "ortho_piece"
	
	var dictionary_index = 0
	all_tiles_coordinates = get_used_cells()
	for n in all_tiles_coordinates:
		all_tiles[n] = dictionary_index
		dictionary_index += 1
	
	#print(get_used_cells())
	#print(self.tile_set.get_source(0).get_scene_tile_scene(1)._bundled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Global.tile_center.add_child(ortho_piece_instance)
	if Input.is_action_just_pressed("switch_piece"):
		if current_piece == "ortho_piece":
			current_piece = "diagon_piece"
			piece_label.text = "Diagonal"
		else:
			current_piece = "ortho_piece"
			piece_label.text = "Ortho"

	if Input.is_action_just_pressed("add_piece") && Global.mouse_is_over:
		if current_piece == "ortho_piece":
			modified_tiles = get_surrounding_cells(m_c)
		else:
			modified_tiles = [Vector2i(m_c.x - 1, m_c.y - 1), Vector2i(m_c.x + 1, m_c.y - 1), Vector2i(m_c.x - 1, m_c.y + 1), Vector2i(m_c.x + 1, m_c.y + 1)]
			
		for n in modified_tiles:
			if all_tiles.has(n):
				#set_cell(n, 0, Vector2i(0, 0), 2) #0 is the TileSet id, 2 is the Tile id
				#print(local_to_map(Global.tiles_dictionary[n].get_node("TileCenter").global_position))
				if Global.tiles_dictionary[n].has_node("Dot"):
					Global.tiles_dictionary[n].remove_child(Global.tiles_dictionary[n].get_children()[3])
				else:
					dot_instance = dot_scene.instantiate()
					Global.tiles_dictionary[n].add_child(dot_instance)
			else:
				pass

func get_cell_coordinates():
	m_c = local_to_map(get_local_mouse_position())
	print(m_c)

func _on_tile_map_area_mouse_exited() -> void:
	Global.mouse_is_over = false
