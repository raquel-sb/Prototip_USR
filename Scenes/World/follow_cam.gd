extends Camera2D

@export var tilemap: TileMapLayer
@export var follow_node: Player

func _ready() -> void:
	var map_rectangle = tilemap.get_used_rect()
	var tile_size = tilemap.rendering_quadrant_size
	var map_size_in_pixels = map_rectangle.size * tile_size * GameState.world_scale
	
	# The camera follows the player until finds bottom or right borders 
	# (top and left are set to 0 by hand)
	limit_right = map_size_in_pixels.x
	limit_bottom = map_size_in_pixels.y


func _process(delta: float) -> void:
	global_position = follow_node.global_position
