class_name BaseScene extends Node

@onready var player: Player
@onready var camera: Camera2D = $FollowCam
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var npc_container: Node2D = $NPCContainer

func _ready() -> void:
	# Save current scene path
	var current_path = get_tree().current_scene.scene_file_path
	SceneManager.remember_new_scene(current_path)
	
	# Update player
	if not SceneManager.player:
		SceneManager.set_player(player) # Primera vez que cargamos
	if not player:
		player = SceneManager.player
		print("Add player")
		add_child(player)

	# Move camera
	camera.follow_node = player
	camera.make_current()
	camera.zoom = GameState.zoom_camera_scene[self.name]
	
	'''
	if SceneManager.player:
		if not player:
			player = SceneManager.player
			add_child(player)
			# player.queue_free()
		
		# player = SceneManager.player
		# add_child(player)
	else:
		SceneManager.set_player(player)
	'''
	
	# Set position of the player
	if GameState.player_data.saved_position:
		print("Saved pos")
		player.global_position = GameState.player_data.saved_position
		GameState.player_data.saved_position = null
	else:
		print("Not saved pos")
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
			# SceneManager.player.global_position = entrance.global_position
			pass
