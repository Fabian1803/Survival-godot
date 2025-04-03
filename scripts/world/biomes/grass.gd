extends Node3D

@onready var player = $"../../player"  # Ajusta la ruta si es necesario

func _process(delta):
	if player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		look_at(global_transform.origin - direction, Vector3.UP)
