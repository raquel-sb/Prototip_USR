extends Node


var npc_states = {
	"madre": {
		"scene": "casa",
		"scale": Vector2(0.312, 0.315),
		"position": Vector2(256, 515),
		"next_dialogue": "start"
	},
	"hermana": {
		"scene": "casa",
		"scale": Vector2(0.328, 0.328),
		"position": Vector2(451, 249),
		"next_dialogue": "start"
	},
	"abuelo": {
		"scene": "casa",
		"scale": Vector2(0.29, 0.29),
		"position": Vector2(226, 195),
		"next_dialogue": "start",
		"amount_talk_river": 0
	},
	"maite": {
		"scene": "",
		"scale": 1,
		"position": Vector2(200, 250),
		"next_dialogue": "start"
	},
}


var npc_positions = {
	"madre": {
		"casa": Vector2(256, 515),
	},
	"maite": {
		"casa": Vector2(256, 726)
	},
	"abuelo": {
		# "casa": Vector2(226, 195),
		"rio": Vector2(337, 203)
	},
}

func spawn_npcs(scene_node: BaseScene):
	var container = scene_node.npc_container
	
	# Elimina todos los NPCs anteriores
	for child in container.get_children():
		child.queue_free()
	
	# Carga los NPC's
	for npc_name in NPCManager.npc_states:
		var npc_data = NPCManager.npc_states[npc_name]
		
		# Si la escena del NPC corresponde a la escena actual, lo cargamos
		if npc_data.scene == scene_node.name:
			var npc_scene = load("res://Scenes/Characters/NPC/%s.tscn" % npc_name).instantiate()
			npc_scene.position = npc_data.position
			npc_scene.scale = npc_data.scale
			container.add_child(npc_scene)


func move_npc(npc_name: String, new_scene: String, new_pos: Vector2, new_dialogue: String = "", delete_npc: bool = false):
	npc_states[npc_name].scene = new_scene
	npc_states[npc_name].position = new_pos
	if new_dialogue != "":
		npc_states[npc_name].next_dialogue = new_dialogue
	
	# Borrar al NPC actual si está en esta escena
	if delete_npc:
		var npc_node = get_node_or_null(npc_name)  # o búscalo de otra forma si no es hijo directo
		if npc_node:
			npc_node.queue_free()
