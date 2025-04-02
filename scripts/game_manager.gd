extends Node

# Variable global para el bioma actual
var current_biome = "Grassland"

func _ready():
	print("Game Manager cargado con bioma: ", current_biome)

# Cambiar de bioma
func change_biome(new_biome):
	current_biome = new_biome
	print("Nuevo bioma: ", current_biome)
