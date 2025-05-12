extends Area2D
	
var last_position := Vector2.ZERO

func _ready():
	last_position = global_position

func _process(delta):
	# Mueve la red a la posición del ratón
	var current_position = get_global_mouse_position() # + 0.75*get_global_mouse_position()
	var velocity = current_position - last_position

	# Mueve la red al ratón
	global_position = current_position

	# Accede al Sprite2D hijo
	var sprite := $Sprite2D  # ajusta el path si no se llama así

	# Si se mueve hacia la izquierda, voltea horizontalmente
	if velocity.x < -1:
		sprite.flip_h = false
	elif velocity.x > 1:
		sprite.flip_h = true
		
	last_position = current_position
