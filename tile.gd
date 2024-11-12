extends Node2D

var tile_coordinates

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_coordinates = get_parent().local_to_map(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_tile_area_mouse_entered() -> void:
	Global.mouse_is_over = true
	Global.tile_center = get_node("TileCenter")
	get_parent().get_cell_coordinates()
