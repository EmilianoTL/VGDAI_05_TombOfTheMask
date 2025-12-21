extends CharacterBody2D

@export var speed: float = 400.0
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_moving: bool = false
var move_dir: Vector2 = Vector2.ZERO
var orientation: Vector2 = Vector2.RIGHT

func _ready() -> void:
	anim_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if is_moving:
		var collision = move_and_collide(move_dir * speed * delta)
		if collision:
			var collider = collision.get_collider()
			print(collider)
			if collider.is_in_group("Spikes"):
				morir() # Función personalizada para morir
				return # Salimos para no ejecutar la lógica de pared (rotación, etc)
			is_moving = false
			anim_sprite.play("idle")
			look_at(position + orientation)
	else:
		handle_input()

func handle_input() -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input == Vector2.ZERO:
		return
		
	if abs(input.x) > abs(input.y): input.y = 0
	else: input.x = 0
	input = input.normalized()
	if input == -orientation.orthogonal():
		return 
	move_dir = input
	orientation = move_dir.orthogonal()
	
	is_moving = true
	look_at(position + move_dir)
	anim_sprite.play("dash")

func morir() -> void:
	print("¡Has muerto!")
	# "disable the Movement"
	is_moving = false
	move_dir = Vector2.ZERO
	set_physics_process(false) # Bloquea todo el código de movimiento
	
	# "play the Death animation"
	anim_sprite.play("death") 
	
	# "re-start the game after few seconds"
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
