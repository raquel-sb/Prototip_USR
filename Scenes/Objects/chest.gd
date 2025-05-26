extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var connected_scene: String # name of the scene to change to

func _ready() -> void: 
	interactable.interact = _on_interact
	

func _on_interact():
	if sprite_2d.frame == 0:
		sprite_2d.frame = 4
		# interactable.interact_name = "Close Chest"
		
		SceneManager.change_scene(get_owner(), connected_scene)
			
		# interactable.is_interactable = false
	else:
		sprite_2d.frame = 0
		# interactable.interact_name = "Open Chest"

	
