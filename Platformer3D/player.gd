extends RigidBody3D


var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var label := $CanvasLayer/Label

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

@onready var character := $Character

@onready var animator := $AnimationTree
@onready var playback = animator["parameters/playback"]

var blend_path := "parameters/Run/blend_position"


# Deklarieren der Variable coin_count und überschreiben der setter-Methode dieses Attributs
var coin_count := 0:
	set(value):
		coin_count = value
		label.text = "Coins: " + str(coin_count)


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Vector3.ZERO
	input.z = Input.get_axis("move_forward", "move_back")
	input.x = Input.get_axis("move_left", "move_right")
	
	apply_central_force(twist_pivot.basis * input * 1800.0 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-30), deg_to_rad(30))
	
	twist_input = 0
	pitch_input = 0
	
	# Animation des Characters
	if not input.is_zero_approx():
		var move_direction = twist_pivot.basis * input
		var align = character.transform.looking_at(character.transform.origin - move_direction)
		character.transform = character.transform.interpolate_with(align, delta * 20.0)
	
	animator[blend_path] = lerp(animator[blend_path], input.length(), delta * 5.0)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sensitivity
			pitch_input = -event.relative.y * mouse_sensitivity
	
	if event.is_action_pressed("jump"):
		if $RayCast3D.is_colliding():
			apply_central_impulse(Vector3.UP * 15.0)
			playback.start("Hop")
