extends Node

var scene_dir_path = "res://Scenes/"
var player: Player
var last_scene_name: String
var last_scene_change_time := 0.0

func set_player(given_player: Player):
	player = given_player

func change_scene(given_player: Player, from: Node2D, to_scene_name: String) -> void:
	# Evitamos que se cambie de escena demasiado rápido
	if Time.get_ticks_msec() - last_scene_change_time < 500:
		# print("Scene change ignored to prevent looping")
		return
	
	print("Change_scene")
	last_scene_change_time = Time.get_ticks_msec()
	
	# Guardamos nombre de la escena para los EntranceMarkers
	last_scene_name = from.name
	
	# Eliminamos el player de la escena de la que venimos
	from.remove_child(given_player)
	
	# Cargamos nueva escena
	var full_path = scene_dir_path + to_scene_name + ".tscn" # full path of new scene
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	
	'''
	last_scene_name = from.name
	# player = from.player # change selected player???
	if given_player == from.player:
		player = given_player
		from.remove_child(player) # remove that player from origin scene
	
		var full_path = scene_dir_path + to_scene_name + ".tscn" # full path of new scene
		from.get_tree().call_deferred("change_scene_to_file", full_path)
	'''


func remember_new_scene(new_path: String):
	# Nos guardamos el nombre de la escena anterior
	if GameState.current_scene_path:
		GameState.previous_scene_path = GameState.current_scene_path
	GameState.current_scene_path = new_path
