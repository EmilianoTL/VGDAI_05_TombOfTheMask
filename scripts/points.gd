extends Area2D

@export var PointReward: int = 1 
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_trinket: AudioStreamPlayer2D = $SfxTrinket
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	anim_sprite.play('idle')
	sfx_trinket.volume_db=-25
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		GameManager.add_score(PointReward)
		collision.set_deferred("disabled", true)
		sfx_trinket.play()
		anim_sprite.play("pickup") 
		await anim_sprite.animation_finished
		queue_free()
