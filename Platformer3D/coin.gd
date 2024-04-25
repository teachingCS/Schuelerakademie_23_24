extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		var tween := create_tween().set_parallel(true)
		tween.tween_property(self, "global_position", body.global_position, 0.2)
		tween.tween_property(self, "scale", Vector3.ZERO, 0.2)
		tween.set_parallel(false)
		# Ab hier soll der Tween nicht mehr parallel laufen, dass nicht gleichzeitig während der Animation der Coin verschwindet
		tween.tween_callback(
			# Anonyme Funktion die die Setter-Methode in der Klasse Player aufruft
			func(): body.coin_count += 1
		)
		tween.tween_callback(queue_free)
