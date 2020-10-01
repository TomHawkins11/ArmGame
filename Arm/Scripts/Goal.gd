extends RigidBody2D

export(NodePath) var torchPath
onready var torch = get_node(torchPath)
export(NodePath) var game_controller_path
onready var game_controller = get_node(game_controller_path)
var win = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(delta):
	var bodies = $Detector.get_overlapping_bodies()
	for b in bodies:
		print(b.name)
		if b.name == torch.name:
			win = true
			game_controller.next_level()
			
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
