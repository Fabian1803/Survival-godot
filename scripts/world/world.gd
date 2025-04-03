extends Node3D

@onready var world_generator = preload("res://scenes/world/world_generator.tscn")

func _ready():
	var generator_instance = world_generator.instantiate()
	add_child(generator_instance)  # Agrega el generador al mundo
