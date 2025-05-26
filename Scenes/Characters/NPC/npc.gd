extends Node2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var dialogue_script = preload("res://Dialogue/npc_madre.dialogue")

func _ready() -> void: 
	interactable.interact = _on_interact
	

func _on_interact():
	# interactable.interact_name = "Is not answering ..."
	var next = NPCManager.npc_states[self.name].next_dialogue
	DialogueManager.show_example_dialogue_balloon(dialogue_script, next)
	# await get_tree().create_timer(2).timeout
	
	# OS.delay_msec(2000)
