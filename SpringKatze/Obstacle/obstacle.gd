extends Area2D

var speed : int = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x = position.x - speed


func _on_body_entered(body):
#	print("berührt")
	get_tree().quit()
