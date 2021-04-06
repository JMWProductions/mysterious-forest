extends KinematicBody2D

var player: Node2D
var velocity = Vector2.ZERO
var knockbacked
var countdown
var instance_id
var direction

const SPEED = 33.0

func _ready():
  player = get_tree().get_root().get_node("World").get_node("Player")
  knockbacked = false
  countdown = 0
  instance_id = get_instance_id()

func _process(delta):
  if player != null:
    direction = (player.position - position).normalized()
    rotation = direction.angle() + PI / 2
  if knockbacked != true:
    velocity = direction * SPEED

    for i in get_slide_count():
      if get_slide_collision(i).collider.name.begins_with("Bush"):
        velocity = 2 * velocity.rotated(PI / 4)
    velocity = move_and_slide(velocity)
  else:
    velocity = direction * -750
    move_and_slide(velocity)
    countdown += 1
    if countdown == 3:
      knockbacked = false
      countdown = 0




