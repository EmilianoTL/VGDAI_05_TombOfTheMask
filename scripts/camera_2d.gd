extends Camera2D

@export var player: Node2D  

func _process(_delta):
	if player:
		global_position.y = player.global_position.y
