extends Area2D

var speed : int = 10
var animationArray = ["couch", "family", "kittens", "maru", "pile", "pizza", "sloth"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play(animationArray.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x = position.x - speed


func _on_body_entered(body):
#	print("berührt")
	GameState.gameover()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	pass
	# Möglichkeit für das Debugging
	# print(speed)
