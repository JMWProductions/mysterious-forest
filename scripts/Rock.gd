extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var starting_position
var is_rolling
var starting_direction

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0
	is_rolling = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (((position - starting_position).length() > 70) && is_rolling == false):
			is_rolling = true
			add_central_force((get_global_mouse_position() - position).normalized() * -50)
	if (starting_direction != (get_global_mouse_position() - position).normalized()):
		pass
