extends Node2D

@onready var zona_colgado = $AreaColgado
@onready var puntos_colgado = $Markers.get_children().filter(func(n): return n is Marker2D)

# Distancia mínima para que no se solapen prendas colgadas
const RADIO_MINIMO = 1
signal minigame_finished

func _ready():
	print("Minijuego iniciado")

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Al hacer clic izquierdo, revisamos si hay alguna prenda en mano solapando la zona de colgado
		for area in zona_colgado.get_overlapping_areas():
			if area is Area2D and area.has_method("esta_en_mano") and area.esta_en_mano():
				var prenda = area
				var punto = buscar_punto_mas_cercano_disponible(prenda.get_node("PuntoColgado").global_position) #prenda.global_position
				
				# Colgamos la prenda
				if punto:
					# prenda.global_position = punto.global_position
					prenda.colgar_en_marker(punto)
					# prenda.set_en_mano(false)
					return

func buscar_punto_mas_cercano_disponible(posicion_prenda: Vector2) -> Marker2D:
	# print("NEW")
	var punto_mas_cercano: Marker2D = null
	var distancia_minima = 200

	for punto in puntos_colgado:
		var ocupado = false
		for prenda in get_tree().get_nodes_in_group("prendas"):
			var marker_prenda = prenda.get_node("PuntoColgado")
			if marker_prenda.global_position.distance_to(punto.global_position) < RADIO_MINIMO:
				ocupado = true
				break
		if not ocupado:
			var dist = posicion_prenda.distance_to(punto.global_position)
			# print("dist:", dist)
			if dist < distancia_minima:
				# print("-- update punto")
				distancia_minima = dist
				punto_mas_cercano = punto
	# print(" ")
	return punto_mas_cercano


func _on_button_terminar_pressed() -> void:
	print("Button terminar pressed")
	$CanvasLayer/ButtonTerminar.disabled = true
	GameFlow.end_minigame()
