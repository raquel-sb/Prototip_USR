extends Node2D

# @export var hoja_scene: PackedScene
# Array de escenas de hoja
var hoja_scenes: Array[PackedScene] = [
	preload("res://Scenes/MiniGames/Piscina/hoja_01.tscn"),
	preload("res://Scenes/MiniGames/Piscina/hoja_02.tscn"),
	preload("res://Scenes/MiniGames/Piscina/hoja_03.tscn"),
	preload("res://Scenes/MiniGames/Piscina/hoja_04.tscn"),
	preload("res://Scenes/MiniGames/Piscina/hoja_05.tscn"),
]

@export var spawn_interval_range := Vector2(0.25, 2.0)  # intervalo aleatorio entre hojas
# @export var spawn_interval := 2.0  # tiempo entre hojas
@export var screen_right_edge := 1980  # posición X fuera de pantalla derecha (ajusta a tu resolución base)
@export var y_spawn_range := Vector2(150, 800)  # altura aprox. del agua (ajusta según tu escena)

var timer := 0.0
var next_spawn_time := 2.0  # se inicializa al principio

func _ready():
	var screen_right_edge = get_viewport().get_visible_rect().size.x
	
	next_spawn_time = randf_range(spawn_interval_range.x, spawn_interval_range.y)

func _process(delta):
	timer += delta
	if timer >= next_spawn_time:
		# Reseteamos el timer
		timer = 0.0
		
		# Generamos la hoja
		spawn_hoja()
		
		# Genera un nuevo intervalo aleatorio para la próxima hoja
		next_spawn_time = randf_range(spawn_interval_range.x, spawn_interval_range.y)

func spawn_hoja():
	# Escoge una escena aleatoria del array
	var escena_hoja := hoja_scenes[randi() % hoja_scenes.size()]
	var hoja = escena_hoja.instantiate()

	var x = screen_right_edge + 50  # empieza un poco más fuera de pantalla
	var y = randf_range(y_spawn_range.x, y_spawn_range.y)

	hoja.global_position = Vector2(x, y)
	get_tree().current_scene.add_child(hoja)
