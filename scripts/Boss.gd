extends KinematicBody2D

var player: Node2D
var velocity = Vector2.ZERO

const SPEED = 33.0

func _ready():
  player = get_tree().get_root().get_node("World").get_node("Player")
  pass # Replace with function body.

func _process(delta):
  var direction = (player.position - position).normalized()
  rotation = direction.angle() + PI / 2
  velocity = direction * SPEED
  velocity = move_and_slide(velocity)
  
