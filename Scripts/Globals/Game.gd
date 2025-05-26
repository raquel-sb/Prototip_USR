extends Node

var player: Player

func create_player_if_needed():
	if player == null:
		player = preload("res://Scenes/Characters/Mila/Mila.tscn").instantiate()
		get_tree().root.add_child(player)
		player.name = "Player"
