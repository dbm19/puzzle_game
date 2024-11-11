extends TileMapLayer

var ortho_piece_scene
var ortho_piece_instance
var dot_scene
var dot_instance
var mouse_coordinates
var ortho_tiles
var all_tiles_coordinates
var all_tiles = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ortho_piece_scene = preload("res://ortho_piece.tscn")
	dot_scene = preload("res://dot.tscn")

	var dictionary_index = 0
	all_tiles_coordinates = get_used_cells()
	for n in all_tiles_coordinates:
		all_tiles[n] = dictionary_index
		dictionary_index += 1
	
	print(get_used_cells())
	#print(self.tile_set.get_source(0).get_scene_tile_scene(1)._bundled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_piece") && Global.mouse_is_over:
		ortho_piece_instance = ortho_piece_scene.instantiate()
		dot_instance = dot_scene.instantiate()
		Global.tile_center.add_child(ortho_piece_instance)
		ortho_tiles = get_surrounding_cells(mouse_coordinates)
		
		for n in ortho_tiles:
			if all_tiles.has(n):
				pass
				#print(get_used_cells_by_id(0, n))
				#print(get_cell_source_id(n))
				#print(get_cell_tile_data(n))
				#print(self.get_cell_tile_data(n))
				#print(n)
				set_cell(n, 1, Vector2i(0, 0), 2)
			else:
				pass

func get_cell_coordinates():
	mouse_coordinates = local_to_map(get_viewport().get_mouse_position())
	#print(get_cell_atlas_coords(mouse_coordinates))

func _on_tile_map_area_mouse_exited() -> void:
	Global.mouse_is_over = false
