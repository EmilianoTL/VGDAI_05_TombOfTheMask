extends Area2D

@export var PointReward: int  = 0
@export var CordinateSprite: Vector2 = Vector2(0,0) 

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	sprite_2d.frame_coords=CordinateSprite
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		# 1. Sumar puntos
		print("entro")
		GameManager.add_score(PointReward)
		# 2. Reproducir sonido (ver punto 3)
		# 3. Desaparecer
		queue_free()
