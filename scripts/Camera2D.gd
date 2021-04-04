extends Camera2D

var player

func _ready():
  player = get_tree().get_root().get_node("World").get_node("Player")
  
func _process(delta):
  position = player.position
