extends BaseScene

func _ready() -> void:
	
	# Revisamos objeto para finalizar el prototipo
	var cake = $cake
	var child_node = $cake/Interactable
	cake.visible = GameState.cake
	child_node.is_interactable = GameState.cake
	
	super()
