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
var contract_counter
var cooldown_collectibles = 0


# Called when the node enters the scene tree for the first time.
func _ready():
  rock = preload("../scenes/Rock.tscn")
  boss = preload("../scripts/Boss.gd")
  rock_counter = 3
  contract_counter = 0
  cooldown = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  manage_velocity(delta)
  manage_actions()
  velocity = move_and_slide(velocity)
  if cooldown != 0:
    cooldown -= 1
  if cooldown_collectibles != 0:
    cooldown_collectibles -= 1
  check_for_collisions()
  
  if contract_counter == 6:
    get_tree().change_scene("res://scenes/Victory.tscn")
    
func updateLabel():
  get_node("Label").set_text("Liczba kamieni: " + str(rock_counter) + "\nLiczba kontraktów: " + str(contract_counter))


func check_for_collisions():
  for i in get_slide_count():
    if get_slide_collision(i).collider.name.begins_with("Boss"):
      get_tree().change_scene("res://scenes/Defeat.tscn")
    if get_slide_collision(i).collider.has_method("collect") and cooldown_collectibles == 0:
      contract_counter += 1
      cooldown_collectibles = 2
      get_slide_collision(i).collider.collect()
      get_node("Label").set_text("Liczba kamieni: " + str(rock_counter) + "\nLiczba kontraktów: " + str(contract_counter))



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
    get_node("Label").set_text("Liczba kamieni: " + str(rock_counter) + "\nLiczba kontraktów: " + str(contract_counter))
    cooldown = 50

