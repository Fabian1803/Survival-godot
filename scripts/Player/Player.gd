extends CharacterBody3D

@export var speed = 5.0
@export var jump_force = 8.0
@onready var gravity = ProjectSettings.get("physics/3d/default_gravity")
@onready var camera = get_node_or_null("Camera")  # Evita error si la cámara no existe

func _ready():
	if camera == null:
		print("⚠️ ERROR: No se encontró la cámara dentro de Player")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta  # Aplica gravedad

	# Si la cámara no existe, evitar errores
	if camera == null:
		return  

	var forward = -camera.global_transform.basis.z
	var right = camera.global_transform.basis.x
	
	var direction = Vector3.ZERO
	if Input.is_action_pressed("tap_top"):
		direction += forward
	if Input.is_action_pressed("tap_down"):
		direction -= forward
	if Input.is_action_pressed("tap_left"):
		direction -= right
	if Input.is_action_pressed("tap_right"):
		direction += right

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	if Input.is_action_just_pressed("tap_accept") and is_on_floor():
		velocity.y = jump_force  # Salto

	move_and_slide()
