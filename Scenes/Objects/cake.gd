extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var connected_scene: String # name of the scene to change to

func _ready() -> void: 
	interactable.interact = _on_interact
	

func _on_interact():
	SceneManager.change_scene(get_owner(), connected_scene)
	# interactable.is_interactable = false
