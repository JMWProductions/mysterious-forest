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
  contact_monitor = true
  contacts_reported = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  if (((position - starting_position).length() > 70) and is_rolling == false):
    is_rolling = true
    add_central_force(-starting_direction * 500)
  if (abs((starting_direction - linear_velocity.normalized()).length()) > 0.0001 and is_rolling == true):
    set_applied_force(Vector2(0,0))
    set_linear_velocity(Vector2(0,0))

func _on_Node2D_body_entered(body):
  if body.get_name() == "Player":
    body.rock_counter += 1
    self.queue_free()
  if body.get_name() == "Boss" && is_rolling != true:
    body.knockbacked = true
