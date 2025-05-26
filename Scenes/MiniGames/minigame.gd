extends Node2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
# @onready var player_node: CharacterBody2D = $"../Mila"

@export var minigame_scene = "res://Scenes/MiniGames/Tender/Tender.tscn"

func _ready() -> void: 
	interactable.interact = _on_interact
	

func _on_interact():
	# interactable.interact_name = "Is not answering ..."
	print("interact")
	# GameFlow.launch_minigame(minigame_scene, get_tree().get_current_scene().get_node("MinigameLayer"))
	print("Player pos: ", SceneManager.player.global_position)
	print("Is inside tree?", SceneManager.player.is_inside_tree())
	GameState.player_data.saved_position = SceneManager.player.global_position #player_node.position #  Guardamos current position del player
	GameFlow.start_minigame(minigame_scene)
