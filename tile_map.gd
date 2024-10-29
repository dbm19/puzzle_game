extends TileMapLayer

var ortho_piece_scene
var ortho_piece_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ortho_piece_scene = preload("res://ortho_piece.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_piece") && Global.mouse_is_over:
		ortho_piece_instance = ortho_piece_scene.instantiate()
		Global.tile_center.add_child(ortho_piece_instance)
