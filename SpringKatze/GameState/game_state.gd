extends Node

var highscore : int
var current_score : int


func gameover():
	if (current_score > highscore):
		highscore = current_score
	current_score = 0
