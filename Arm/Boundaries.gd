extends Node

export(NodePath) var upper_bounds_path
onready var upper_bounds:Position2D = get_node(upper_bounds_path)

export(NodePath) var lower_bounds_path
onready var lower_bounds:Position2D = get_node(lower_bounds_path)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func get_all_rb():
	var n=[]
	for c in ():
    	if c extends DesiredClass:
        	n.append(c)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
