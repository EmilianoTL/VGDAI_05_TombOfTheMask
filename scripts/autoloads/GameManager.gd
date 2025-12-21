extends Node

var score = 0

func add_score(points):
	score += points
	print("Score: ", score)

func restart_game():
	get_tree().reload_current_scene()
