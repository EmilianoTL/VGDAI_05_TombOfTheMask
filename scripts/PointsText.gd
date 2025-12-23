extends Label

func _process(_delta):
	text = "Points: %d (Max: %d)\nHeight: %d (Max: %d)" % [
		GameManager.current_points, 
		GameManager.max_points,
		GameManager.current_height,
		GameManager.max_height
	]
