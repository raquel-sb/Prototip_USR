extends Area2D

# @export var event_id: String = self.name

func _ready() -> void:
	if GameState.completed_events.get(self.name, false):
		queue_free()
	else:
		connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body is Player:
		GameFlow.trigger_event(self.name)
		GameState.completed_events[self.name] = true
		queue_free()  # Opcional: destruye el trigger tras usarlo
