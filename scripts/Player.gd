extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity;
var mouse_position;
var speed;
var rock;
var rock_counter;
var cooldown
var boss


# Called when the node enters the scene tree for the first time.
func _ready():
  rock = preload("../scenes/Rock.tscn")
  boss = preload("../scripts/Boss.gd")
  rock_counter = 3
  cooldown = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  manage_velocity(delta)
  manage_actions()
  velocity = move_and_slide(velocity)
  if cooldown != 0:
    cooldown -= 1
  check_for_death()


func check_for_death():
  for i in get_slide_count():
    if get_slide_collision(i).collider.name == "Boss":
      self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.

func manage_velocity(delta):
  velocity = Vector2.ZERO
  mouse_position = get_global_mouse_position()
  var vector = mouse_position - position
  rotation = vector.angle()

  if Input.is_action_pressed("move_up"):
    velocity.y = -60
  if Input.is_action_pressed("move_down"):
    velocity.y = 60
  if Input.is_action_pressed("move_right"):
    velocity.x = 60
  if Input.is_action_pressed("move_left"):
    velocity.x = -60

func manage_actions():
  if Input.is_action_just_pressed("left_mouse_clicked") and rock_counter != 0 && cooldown == 0:
    var rock_inst = rock.instance()
    owner.add_child(rock_inst)
    rock_inst.transform = $aim_point.global_transform
    rock_inst.starting_position = $aim_point.global_position
    rock_inst.apply_central_impulse((mouse_position - position).normalized() * 350)
    rock_inst.starting_direction = (mouse_position - position).normalized()
    rock_counter -= 1
    cooldown = 50

