class_name BaseScene extends Node

@onready var player: Player
@onready var camera: Camera2D = $FollowCam
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var npc_container: Node2D = $NPCContainer

func _ready() -> void:
	# Move player and camera
	if SceneManager.player:
		if player:
			player.queue_free()
		
		player = SceneManager.player
		add_child(player)
		
		camera.follow_node = player
		camera.make_current()
		camera.zoom = GameState.zoom_camera_scene[self.name]
	
	# Set position of the player
	if GameState.player.saved_position:
		player.global_position = GameState.player.saved_position
		GameState.player.saved_position = null
	else:
		position_player()
	
	# Spawn the NPC's
	NPCManager.spawn_npcs(self)



func position_player() -> void:
	var last_scene = SceneManager.last_scene_name
	
	if last_scene.is_empty():
		last_scene = "any"
		
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and (entrance.name == "any" or entrance.name == last_scene):
			player.global_position = entrance.global_position
			pass
