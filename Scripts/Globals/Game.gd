extends Node

var player: Player

func create_player_if_needed():
	if player == null:
		print("Create player")
		player = preload("res://Scenes/Characters/Mila/Mila.tscn").instantiate()
		# get_tree().root.add_child(player)

# Movemos al player al root
func remove_player(from: Node2D):
	print("Player removed, ", from.name)
	from.remove_child(Game.player)
	# get_tree().root.add_child(Game.player)
