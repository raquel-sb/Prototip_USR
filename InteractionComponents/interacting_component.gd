extends Node2D


@onready var interact_label: Label = $InteractLabel

var current_interactions := []
var can_interact: bool = true


# When user's press the interaction button, the label dissapears
func _input(event: InputEvent) -> void:
	
	# bloquea todos los inputs si hay diálogo
	if GameState.is_dialogue_playing:
		return  
	
	# Si puede existir interacción
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			can_interact = false # deactivate
			interact_label.hide() # hide label / text of the interaction
			
			# Wait for the interaction to finish (it may be a dialogue, etc)
			await current_interactions[0].interact.call()
			
			can_interact = true # activate again


func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		
		# Ordering of the current_interactions list according to more nearest interactable
		current_interactions.sort_custom(_sort_by_nearest) # sort the list
		
		# Check the first element of the list: is it interactable?
		if current_interactions[0].is_interactable:
			interact_label.text = current_interactions[0].interact_name # get the name
			interact_label.show() # show the name
	else:
		interact_label.hide() # hide the name


# Custom function of ordering the interactions listed
func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area) # add current area inside the list


func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interactions.erase(area) # delete current area from the list
