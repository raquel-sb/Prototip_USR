extends Area2D


@export var lista_prendas: Array[PackedScene] = [
	preload("res://Scenes/MiniGames/Tender/PrendaToalla.tscn"),
	preload("res://Scenes/MiniGames/Tender/PrendaShort.tscn"),
	preload("res://Scenes/MiniGames/Tender/PrendaPantalon.tscn"),
	preload("res://Scenes/MiniGames/Tender/PrendaCalcetines.tscn"),
	preload("res://Scenes/MiniGames/Tender/PrendaJersey.tscn"),
	preload("res://Scenes/MiniGames/Tender/PrendaCamiseta.tscn")
]

@onready var zona_colision = $CollisionShape2D
@onready var prenda_container = $"../PrendaContainer"


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Si el jugador ya tiene una prenda, comprobar si quiere devolverla al cesto
		if hay_prenda_en_mano():
			var prenda = obtener_prenda_en_mano()
			if prenda and esta_dentro_del_cesto(prenda.global_position):
				# Restauramos los valores
				prenda.set_en_mano(false) # Jugador no tiene prenda en mano
				prenda.queue_free() # Quitamos la prenda de la escena
				lista_prendas.push_back(prenda.scene_referencia) # Añadimos la prenda a la lista de prendas
			return
		
		# Si no hay prenda en mano, intenta sacar una nueva
		if esta_dentro_del_cesto(get_global_mouse_position()):
			sacar_prenda()

func sacar_prenda():
	# Si ya no hay más prendas para sacar
	if lista_prendas.is_empty():
		return
	
	# Saca la siguiente prenda
	var prenda_escena = lista_prendas.pop_back()  # Saca la última prenda
	
	# Creamos el nodo en la escena
	var nueva_prenda = prenda_escena.instantiate()
	nueva_prenda.scene_referencia = prenda_escena  # <- Guardamos de dónde vino (la escena)
	# get_tree().root.add_child(nueva_prenda)
	prenda_container.add_child(nueva_prenda)
	nueva_prenda.global_position = get_viewport().get_mouse_position()
	
	# Indicamos que esta nueva prenda está en la "mano" del jugador
	nueva_prenda.set_en_mano(true)

func hay_prenda_en_mano() -> bool:
	return obtener_prenda_en_mano() != null

func obtener_prenda_en_mano():
	for prenda in get_tree().get_nodes_in_group("prendas"):
		if prenda.has_method("esta_en_mano") and prenda.esta_en_mano():
			return prenda
	return null

func esta_dentro_del_cesto(pos: Vector2) -> bool:
	var local_pos = zona_colision.get_global_transform().affine_inverse() * pos
	return local_pos.distance_to(Vector2.ZERO) < 100  # Ajusta el radio
