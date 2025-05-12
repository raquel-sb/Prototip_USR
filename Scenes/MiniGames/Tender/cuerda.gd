extends Node2D

@onready var zona_colgado = $Area2D
@onready var puntos_colgado = get_children().filter(func(n): return n is Marker2D)

# Distancia mínima para que no se solapen prendas colgadas
const RADIO_MINIMO = 40

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Al hacer clic izquierdo, revisamos si hay alguna prenda en mano solapando la zona de colgado
		for area in zona_colgado.get_overlapping_areas():
			if area is Area2D and area.has_method("esta_en_mano") and area.esta_en_mano():
				var prenda = area
				var punto = buscar_punto_mas_cercano_disponible(prenda.global_position)
				
				# Colgamos la prenda
				if punto:
					# prenda.global_position = punto.global_position
					prenda.colgar_en_marker(punto)
					prenda.set_en_mano(false)
					return

func buscar_punto_mas_cercano_disponible(posicion_prenda: Vector2) -> Marker2D:
	var punto_mas_cercano: Marker2D = null
	var distancia_minima = INF

	for punto in puntos_colgado:
		var ocupado = false
		for prenda in get_tree().get_nodes_in_group("prendas"):
			if prenda.global_position.distance_to(punto.global_position) < RADIO_MINIMO:
				ocupado = true
				break
		if not ocupado:
			var dist = posicion_prenda.distance_to(punto.global_position)
			if dist < distancia_minima:
				distancia_minima = dist
				punto_mas_cercano = punto

	return punto_mas_cercano
