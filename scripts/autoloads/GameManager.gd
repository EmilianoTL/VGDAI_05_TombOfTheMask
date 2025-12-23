extends Node

# Variables
var current_points: int = 0
var max_points: int = 0
var current_height: int = 0
var max_height: int = 0
var pos_ini:Vector2 = Vector2(280,392)

#agregar puntos
func add_score(points: int):
	current_points += points
	if current_points > max_points:
		max_points = current_points

func update_height(player_y: float):
	current_height =max(current_height,abs(player_y-pos_ini.y)/16) # El "/10" es para simplificar el número
	
	if current_height > max_height:
		max_height = current_height

func reset_current_run():
	current_points = 0
	current_height = 0
