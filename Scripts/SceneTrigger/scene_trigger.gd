class_name SceneTrigger extends Node

@export var connected_scene: String # name of the scene to change to

func _on_body_entered(body):
	if body is Player:
		SceneManager.change_scene(body, get_owner(), connected_scene)
