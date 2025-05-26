extends Node

var scene_dir_path = "res://Scenes/"
var player: Player
var last_scene_name: String


func change_scene(given_player: Player, from: Node2D, to_scene_name: String) -> void:
	print("Change_scene")
	last_scene_name = from.name
	# player = from.player # change selected player???
	if given_player == from.player:
		player = given_player
		from.remove_child(player) # remove that player from origin scene
	
		var full_path = scene_dir_path + to_scene_name + ".tscn" # full path of new scene
		from.get_tree().call_deferred("change_scene_to_file", full_path)
		
		
