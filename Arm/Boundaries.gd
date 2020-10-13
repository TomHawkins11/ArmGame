extends Node

export(NodePath) var upper_bounds_path
onready var upper_bounds:Position2D = get_node(upper_bounds_path)

export(NodePath) var lower_bounds_path
onready var lower_bounds:Position2D = get_node(lower_bounds_path)

var reset_state = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func get_all_rb():
	for c in (get_tree().get_nodes_in_group("RB")):
		if c is RigidBody2D:
			if get_pos(c).y < lower_bounds.y:
				c.
				

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
