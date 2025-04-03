extends Node3D

@export var terrain_size = 50  # Tamaño del mapa
@export var tree_density = 0.02  # Probabilidad de árboles
@export var grass_density = 0.05  # Probabilidad de pasto
@export var lake_count = 3  # Cantidad de lagos
@export var map_size = 5  # Cuántos terrenos se deben colocar para llenar el mapa (en ambos ejes)
@export var block_size = 2.0  # El tamaño de cada cuadro de terreno

@onready var tree_scene = preload("res://scenes/world/Biomes/Trees/tree.tscn")
@onready var grass_scene = preload("res://scenes/world/Biomes/Grass/grass.tscn")
@onready var lake_scene = preload("res://scenes/world/biomes/Lake/lake.tscn")
@onready var terrain_scene = preload("res://scenes/world/biomes/Terrain/terrain.tscn")

func _ready():
	print("Generando el mundo...")
	generate_terrain()
	generate_trees()
	generate_grass()
	generate_lakes()


func generate_terrain():
	var terrain_instance = terrain_scene.instantiate()  # Crear una instancia del bloque de terreno
	var terrain_size_half = terrain_size / 2  # Mitad del tamaño del mapa para recorrerlo

	# Recorre toda la superficie del mapa generando bloques de terreno
	for x in range(-terrain_size_half, terrain_size_half, block_size):  # Usa el tamaño de cada bloque
		for z in range(-terrain_size_half, terrain_size_half, block_size):  # Usa el tamaño de cada bloque
			var new_terrain = terrain_instance.duplicate()  # Crear una copia del bloque de terreno
			new_terrain.position = Vector3(x, 0, z)  # Colocar el nuevo bloque en la posición correcta
			add_child(new_terrain)  # Añadirlo a la escena

	print("Terreno generado con textura y colisión.")

func generate_trees():
	for x in range(-terrain_size / 2, terrain_size / 2, 2):
		for z in range(-terrain_size / 2, terrain_size / 2, 2):
			if randf() < tree_density:
				var tree = tree_scene.instantiate()
				tree.position = Vector3(x, 0, z)
				add_child(tree)

func generate_grass():
	for x in range(-terrain_size / 2, terrain_size / 2, 1):
		for z in range(-terrain_size / 2, terrain_size / 2, 1):
			if randf() < grass_density:
				var grass = grass_scene.instantiate()
				grass.position = Vector3(x, 0, z)
				add_child(grass)

func generate_lakes():
	for _i in range(lake_count):
		var lake = lake_scene.instantiate()
		lake.position = Vector3(randi_range(-terrain_size / 2, terrain_size / 2),0, randi_range(-terrain_size / 2, terrain_size / 2))
		add_child(lake)
