extends Node


func request_npc_move(npc_name: String, new_scene: String, new_position: Vector2, new_dialogue: String = "", delete_npc: bool = false) -> void:
	NPCManager.move_npc(npc_name, new_scene, new_position, new_dialogue, delete_npc)
	print("Moved NPC %s to %s at %s" % [npc_name, new_scene, new_position])


func trigger_event(event_id: String) -> void:
	print("trigger_event ", event_id)
	match event_id:
		"abuelo_a_rio":
			request_npc_move("abuelo", "rio", NPCManager.npc_positions["abuelo"]["rio"], "start_rio")
		"madre_sale_casa":
			request_npc_move("madre", "", Vector2.ZERO)
		"madre_vuelve_casa":
			request_npc_move("madre", "casa", NPCManager.npc_positions["madre"]["casa"])
		_:
			push_warning("Unknown event: " + event_id)


func start_minigame(minigame_scene_path: String):
	# Guardar escena actual si quieres volver luego
	SceneManager.remember_new_scene(minigame_scene_path)
	
	# Cambiamos a la escena del minijuego
	# get_tree().change_scene_to_file(minigame_scene_path)
	get_tree().call_deferred("change_scene_to_file", minigame_scene_path)
	
	# Print opcional
	print("Path ", GameState.previous_scene_path)


func end_minigame():
	print("Minijuego terminado")
	
	# Vuelve a la escena anterior guardada
	# get_tree().change_scene_to_file(GameState.previous_scene_path)
	if GameState.previous_scene_path:
		get_tree().call_deferred("change_scene_to_file", GameState.previous_scene_path)
	else:
		print("Warning! No existe previous scene path")

'''
func launch_minigame(path_to_minigame: String, parent: Node):
	print("parent name: ", parent.name)
	var minigame_scene = load(path_to_minigame)
	var minigame = minigame_scene.instantiate()

	# Suponiendo que el minijuego emite una señal "minigame_finished"
	minigame.connect("minigame_finished", Callable(self, "_on_minigame_finished").bind(minigame))
	
	parent.add_child(minigame)

func _on_minigame_finished(minigame_node):
	minigame_node.queue_free()
	# Aquí puedes desbloquear al jugador, guardar progreso, etc.
'''
