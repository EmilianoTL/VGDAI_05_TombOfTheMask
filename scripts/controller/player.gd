extends CharacterBody2D

#Exportado
@export var speed: float = 400.0
@export var trail_length: int = 7

#Referencias
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_dead: AudioStreamPlayer2D = $SfxDead
@onready var sfx_jump: AudioStreamPlayer2D = $SfxJump
@onready var trail: Line2D = $Line2D # <--- Referencia a tu nuevo nodo
@onready var fader: ColorRect = $"../CanvasLayer2/ColorRect"

# Variables
var is_moving: bool = false
var move_dir: Vector2 = Vector2.ZERO
var normal: Vector2 = Vector2.UP
var starty: int =392

#Config inicial
func _ready() -> void:
	fader.modulate.a = 1.0
	var entry_tween = create_tween()
	entry_tween.tween_property(fader, "modulate:a", 0.0, 0.5)
	anim_sprite.play("idle")
	trail.top_level = true 
	trail.clear_points()

func _physics_process(delta: float) -> void:
	GameManager.update_height(global_position.y)
	gestionar_trail()
	#Logica de movimiento
	if is_moving:
		var collision = move_and_collide(move_dir * speed * delta)
		#Logica de colision
		if collision:
			var collider = collision.get_collider()
			normal = collision.get_normal()
			
			#Detectar picos
			if collider.is_in_group("Spikes"):
				morir()
				return 
				
			#Dejar de mover
			is_moving = false
			anim_sprite.play("idle")
			anim_sprite.global_rotation = normal.angle() + deg_to_rad(90)
	else:
		handle_input()

func handle_input() -> void:
	#Logica de entrada
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input == Vector2.ZERO:
		return
		
	#Quedar con sola una direccion
	if abs(input.x) > abs(input.y):
		input.y = 0
	else:
		input.x = 0
	input = input.normalized()	
	if -1 * normal == input:
		return
		
	#Hacer Dash
	move_dir = input
	is_moving = true
	anim_sprite.global_rotation = 0
	anim_sprite.look_at(global_position + move_dir)
	sfx_jump.play()
	anim_sprite.play("dash")

#Gestionar trail
func gestionar_trail() -> void:
	trail.add_point(global_position + 4*move_dir)
	if trail.get_point_count() > trail_length:
		trail.remove_point(0)

#Funcion de morir
func morir() -> void:
	if not is_moving and not get_physics_process_delta_time(): return # Evitar múltiples ejecuciones
	
	is_moving = false
	move_dir = Vector2.ZERO
	set_physics_process(false) # Detener lógica de juego
	
	# 1. Visuales y Sonido
	anim_sprite.play("death")
	sfx_dead.play()
	if trail: trail.clear_points() # Limpiar rastro de partículas/líneas
	
	# 2. Efecto de fundido (Fade Out)
	# Creamos un Tween que sube la opacidad del cuadro negro
	var fade_tween = create_tween()
	fade_tween.tween_property(fader, "modulate:a", 1.0, 0.5) # De 0 a 1 en 0.5 segundos
	
	# 3. Esperar el tiempo solicitado en la práctica
	await get_tree().create_timer(2.0).timeout
	
	# 4. Reiniciar datos y escena
	GameManager.reset_current_run() # Pone a 0 puntos y altura actual
	get_tree().reload_current_scene() # Al recargar, los puntos y el mapa aparecen de nuevo
