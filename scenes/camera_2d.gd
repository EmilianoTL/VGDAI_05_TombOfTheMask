extends Camera2D

@export var player: Node2D  
func _ready() -> void:
	global_position.x = 280
func _process(_delta):
	if player:
		global_position.y = player.global_position.y
