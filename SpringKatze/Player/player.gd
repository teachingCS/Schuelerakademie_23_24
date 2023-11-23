extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	$AnimatedSprite2D.play("walk")
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer.play()


	move_and_slide()
