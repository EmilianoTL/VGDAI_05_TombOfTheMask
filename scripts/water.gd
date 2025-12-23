extends Area2D

@export var rise_speed: float = 40.0

func _physics_process(delta: float) -> void:
	# Mueve el agua hacia arriba constantemente
	global_position.y -= rise_speed * delta

func _on_body_entered(body: Node2D) -> void:
	# Verificamos si lo que entró en el agua es el jugador
	if body.is_in_group("Player"):
		# Si el jugador tiene el script con la función morir()
		if body.has_method("morir"):
			body.morir()
		else:
			# Opción de respaldo: si morir() no está disponible, reiniciamos la escena
			get_tree().reload_current_scene()
