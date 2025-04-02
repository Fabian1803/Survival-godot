extends Camera3D

@export var sensitivity = 0.2  # Sensibilidad del movimiento
var rotation_x = 0.0   # Rotación en el eje X
var rotation_y = 0.0   # Rotación en el eje Y
@onready var player = $".."  # Referencia al Player

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Bloquear el cursor en el centro

func _input(event):
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * sensitivity
		rotation_x -= event.relative.y * sensitivity
		rotation_x = clamp(rotation_x, -90, 90)  # Limitar la rotación vertical

		rotation_degrees.x = rotation_x  # Rotación vertical (cámara)
		player.rotation_degrees.y = rotation_y  # Rotación horizontal (jugador)
