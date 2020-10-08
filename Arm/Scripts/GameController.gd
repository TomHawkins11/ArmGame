extends Node2D

export(String, FILE, "*.tscn,*.scn") var next_scene_path
onready var SceneChanger = get_node("CanvasLayer")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass # Replace with function body.
	
			
func next_level():
	SceneChanger.change_scene(next_scene_path)
	
func level_complete():
	next_level()
	
func restart_level():
	get_tree().reload_current_scene()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
		if event.pressed and event.scancode == KEY_R:
			restart_level()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
