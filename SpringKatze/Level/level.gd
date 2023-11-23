extends Node2D

var score : int = 0
# preload der Obstacleszene
const OBSTACLESZENE = preload("res://Obstacle/obstacle.tscn")


func _on_spawn_timer_timeout():
	# erzeugen eines Obstacleobjekts
	var obstacle = OBSTACLESZENE.instantiate()
	# jedes Obstacleobjekt kommt mit einer anderen Geschwindigkeit
	obstacle.speed = randi_range(9,15)
	# die Instanz der Szene als Kind hinzufügen
	add_child(obstacle)
	# unterschiedliche Wartezeiten auf das nächste Obstacle
	$SpawnTimer.wait_time = randf_range(1.4, 4.0)
	
	
	
func _on_score_timer_timeout():
	score += 1
	# ScoreLabel aktualisieren:
	$ScoreLabel.text = "Score: " + str(score)
	# Alternative: $ScoreLabel.text = "Score: %d" % score


