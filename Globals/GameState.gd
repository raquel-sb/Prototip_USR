extends Node

var is_dialogue_playing : bool = false
var world_scale : float = 1

# Condiciones del juego
var talked_to = {
	"Hermana": false,
	"Yayo": false,
	"Madre": false
}

var invitados_fiesta = {
	"Hermana": false,
	"Yayo": false,
	"Marga": false
}

# Diccionarios NPCs de conversaciones
var npc_dict = {
	"madre_dict" = {
		"next": "start",
	},
	
	"hermana_dict" = {
		"next": "start",
	},
	
	"yayo_dict" = {
		"next": "start",
		"amount_talk_river": 0
	},
}
 


func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	# DialogueManager.dialogue_ended.connect(_on_dialogue_ended) # Esto no funciona

func _on_dialogue_started(_entry_point):
	print("Start dialogue")
	is_dialogue_playing = true

func _on_dialogue_ended():
	print("End dialogue")
	is_dialogue_playing = false

func can_player_act() -> bool:
	return not is_dialogue_playing
