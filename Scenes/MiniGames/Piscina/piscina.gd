extends Node2D


func _on_button_pressed() -> void:
	print("Button terminar pressed")
	$CanvasLayer/ButtonTerminar.disabled = true
	GameFlow.end_minigame()
