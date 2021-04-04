extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity;
var mouse_position;


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	manage_velocity(delta)
	move_and_collide(velocity)
		
func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = get_local_mouse_position()
		rotation += mouse_position.angle()

func manage_velocity(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y = -60 * delta
	if Input.is_action_pressed("move_down"):
		velocity.y = 60 * delta
	if Input.is_action_pressed("move_right"):
		velocity.x = 60 * delta
	if Input.is_action_pressed("move_left"):
		velocity.x = -60 * delta
