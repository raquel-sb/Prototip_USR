extends Node

var is_dialogue_playing : bool = false
var world_scale : float = 1
var previous_scene_path : String
var current_scene_path : String
var cake : bool = false


var player_data = {
	"saved_position" = Vector2(347, 176),
}
# zooms de cámara
var zoom_camera_scene = {
	"rio" = Vector2(2, 2),
	"casa" = Vector2(2, 2),
	"end" = Vector2(2, 2),
}
# Condiciones del juego
'''
var talked_to = {
	"hermana": false,
	"abuelo": false,
	"madre": false
}
'''

var invitados_fiesta = {
	"hermana": false,
	"abuelo": false,
	"madre" : true,
	# "maite": false
}

var completed_events = {
	"abuelo_a_rio": false,
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
