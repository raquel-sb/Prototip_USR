extends BaseScene


func _ready() -> void:
	
	# Guardamos el label del mensaje final (para poderlo activar más tarde)
	Game.mensaje_final = $Label
	Game.mensaje_final.visible = false
	
	var states_dict = NPCManager.npc_states
	
	# Actualizamos el diálogo de la madre
	states_dict["madre"]["next_dialogue"] = "final_dialogue"
	
	# Cambiamos la posición de todos los NPC's que pueden ir a la fiesta
	for npc_name in states_dict:
		if npc_name in GameState.invitados_fiesta and GameState.invitados_fiesta[npc_name]:
				states_dict[npc_name]["position"] = $Positions.get_node(npc_name).global_position
				states_dict[npc_name]["scene"] = self.name
	
	super()
	
	# Para aquellos NPC's que sí vienen a la fiesta
	for npc_scene in $NPCContainer.get_children():
		var npc_name = npc_scene.name
		if npc_name in GameState.invitados_fiesta:
			# Los hacemos visibles
			npc_scene.visible = GameState.invitados_fiesta[npc_name]
			
			# Cambiamos diálogos (o los desactivamos)
			if npc_name != "madre":
				npc_scene.get_node("Interactable").is_interactable = false
