extends Node2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var npc_dict_name : String = "" # "madre_dict"
@export var dialogue_script = preload("res://Dialogue/npc_madre.dialogue")

func _ready() -> void: 
	interactable.interact = _on_interact
	

func _on_interact():
	# interactable.interact_name = "Is not answering ..."
	var next = GameState.npc_dict[npc_dict_name].next
	DialogueManager.show_example_dialogue_balloon(dialogue_script, next)
	# await get_tree().create_timer(2).timeout
	# _reset_phone()
	
	# OS.delay_msec(2000)
	# interactable.interact_name = "Call Marga"

func _reset_phone():
	interactable.interact_name = "Mare"
