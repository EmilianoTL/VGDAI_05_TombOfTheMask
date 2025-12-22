extends CharacterBody2D

# --- CONFIGURACIÓN ---
@export var speed: float = 400.0

# --- REFERENCIAS ---
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

# --- ESTADO ---
var is_moving: bool = false
var move_dir: Vector2 = Vector2.ZERO
var normal: Vector2 = Vector2.UP

func _ready() -> void:
	# Iniciamos quieto y mirando a la derecha por defecto
	anim_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if is_moving:
		# Moverse hasta chocar
		var collision = move_and_collide(move_dir * speed * delta)
		
		if collision:
			# 1. Detectar qué tocamos
			var collider = collision.get_collider()
			
			# Si es un pincho, morimos y salimos de la función
			if collider.is_in_group("Spikes"):
				morir()
				return 
			
			# 2. Si es una pared segura: Nos detenemos
			is_moving = false
			anim_sprite.play("idle")
			
			# --- MAGIA DE ROTACIÓN (SOLO SPRITE) ---
			# Obtenemos la flecha que apunta "hacia afuera" de la pared
			normal = collision.get_normal()
			
			# Rotamos solo el dibujo para que los pies (Abajo/+90º) apunten a la pared.
			# Usamos global_rotation para ignorar cualquier rotación previa del padre.
			anim_sprite.global_rotation = normal.angle() + deg_to_rad(90)
			
	else:
		# Si estamos quietos, escuchamos teclas
		handle_input()

func handle_input() -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input == Vector2.ZERO:
		return

	# Evitar diagonales (priorizar el eje más fuerte)
	if abs(input.x) > abs(input.y):
		input.y = 0
	else:
		input.x = 0
	
	# Normalizar para tener dirección pura (1 o -1)
	input = input.normalized()
	
	if -1*normal==input:
		return
	
	# Actualizar dirección
	move_dir = input
	is_moving = true
	
	# --- ROTACIÓN AL MOVERSE ---
	# Reiniciamos la rotación del sprite para que mire hacia donde vamos.
	# IMPORTANTE: Usamos 'look_at' sobre el 'anim_sprite', NO sobre 'self' (el cuerpo).
	anim_sprite.global_rotation = 0 # Limpiamos rotación vieja de la pared
	anim_sprite.look_at(global_position + move_dir)
	
	anim_sprite.play("dash")

func morir() -> void:
	print("¡Has muerto!")
	
	is_moving = false
	move_dir = Vector2.ZERO
	set_physics_process(false) # Bloquea movimiento futuro
	
	anim_sprite.play("death")
	
	# Reiniciar tras 1 segundo
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
