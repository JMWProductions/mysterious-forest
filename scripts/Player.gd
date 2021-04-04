extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity;
var mouse_position;
var speed;
var rock;


# Called when the node enters the scene tree for the first time.
func _ready():
	rock = preload("../scenes/Rock.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	manage_velocity(delta)
	manage_actions()
	velocity = move_and_slide(velocity)

func manage_velocity(delta):
	velocity = Vector2.ZERO
	mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	
	if Input.is_action_pressed("move_up"):
		velocity.y = -60
	if Input.is_action_pressed("move_down"):
		velocity.y = 60
	if Input.is_action_pressed("move_right"):
		velocity.x = 60
	if Input.is_action_pressed("move_left"):
		velocity.x = -60

func manage_actions():
	if Input.is_action_just_pressed("left_mouse_clicked"):
		var rock_inst = rock.instance()
		owner.add_child(rock_inst)
		rock_inst.transform = $aim_point.global_transform
		rock_inst.apply_central_impulse(Vector2(200, 0))
		rock_inst.add_torque(200)
