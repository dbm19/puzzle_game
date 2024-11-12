extends Node

var mouse_is_over
var tile_center
var tiles_loaded
var tiles_dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_is_over = false
	tiles_loaded = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("tile") && tiles_loaded == false:
		for n in get_tree().get_nodes_in_group("tile"):
			tiles_dictionary[n.tile_coordinates] = n
		tiles_loaded = true
		print(tiles_dictionary)
