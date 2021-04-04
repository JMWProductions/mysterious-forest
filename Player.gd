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
	velocity = Vector2.ZERO
	mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	move_and_collide(velocity)
		
