extends Area2D

# Parámetros de movimiento
@export var horizontal_speed := 150.0  # velocidad horizontal constante
@export var amplitude := 5.0          # cuánto se mueve en vertical
@export var frequency := 1.0          # qué tan rápido oscila

var start_position: Vector2
var time := 0.0

func _ready():
	# Para la colisión con la red
	area_entered.connect(_on_area_entered)
	
	# Posición inicial
	start_position = global_position

	# Randomiza la amplitud y frecuencia para que no todas las hojas se muevan igual
	amplitude += randf_range(-2.0, 2.0)
	frequency += randf_range(-0.3, 0.3)

func _process(delta):
	time += delta

	# Movimiento horizontal hacia la izquierda
	start_position.x -= horizontal_speed * delta

	# Movimiento vertical como una onda
	var offset_y = sin(time * frequency * TAU) * amplitude

	global_position = start_position + Vector2(0, offset_y)

	# Eliminar si sale de pantalla (opcional)
	if global_position.x < -100:
		print("La hoja ha salido de la pantalla")
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Red":  # o puedes verificar con `is_in_group("red")` si usas grupos
		print("¡La red ha tocado una hoja!")
		queue_free()
