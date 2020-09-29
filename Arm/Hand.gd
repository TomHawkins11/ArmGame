extends Bone2D

var Mouse_Position

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mouse_Position = get_viewport().get_mouse_position()
	look_at(Mouse_Position)
	global_position = get_global_mouse_position()
	pass
