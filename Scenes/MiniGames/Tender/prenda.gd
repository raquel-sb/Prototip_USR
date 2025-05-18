extends Area2D

var en_mano: bool = true  # cuando se instancia empieza en mano
var next_input_invalid : bool = false
var scene_referencia: PackedScene # para que en el cesto guardemos la escena
@onready var punto_colgado = $PuntoColgado

func _ready():
	add_to_group("prendas")

func _process(delta):
	if en_mano:
		global_position = get_viewport().get_mouse_position()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if !next_input_invalid:
			if !en_mano:
				# Si no está en mano y se hace clic, se recoge
				en_mano = true
				print("Prenda recogida")
			else:
				# Si ya está en mano, se suelta (pero aquí aún no definimos dónde ni cómo)
				# Esto lo controlará otro script (por ejemplo, el del tenderete o el del cesto)
				print("Clic en prenda en mano (esperando que otro nodo decida si soltar)")
		else:
			next_input_invalid = false

func esta_en_mano() -> bool:
	return en_mano

func set_en_mano(valor: bool):
	en_mano = valor

func colgar_en_marker(marker_cuerda: Marker2D):
	print("Colgando")
	var offset = global_position - punto_colgado.global_position
	global_position = marker_cuerda.global_position + offset
	set_en_mano(false)
	next_input_invalid = true
