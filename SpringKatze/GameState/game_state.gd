extends Node

var highscore : int
var current_score : int

func _ready():
	var file = FileAccess.open("user://high-score.txt", FileAccess.READ)
	highscore = file.get_as_text(true).to_int()

func gameover():
	if (current_score > highscore):
		highscore = current_score
		store_highscore_in_file()
	current_score = 0

func store_highscore_in_file():
	var file = FileAccess.open("user://high-score.txt", FileAccess.WRITE)
	file.store_string(str(highscore))
