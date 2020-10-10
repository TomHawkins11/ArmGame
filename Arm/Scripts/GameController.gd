extends Node2D

export(String, FILE, "*.tscn,*.scn") var next_scene_path
onready var SceneChanger = get_node("CanvasLayer")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	music_manage()
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
			SceneChanger.reload_scene()
		if event.pressed and event.scancode == KEY_1:
			SceneChanger.change_scene("res://Scene/Level_1.tscn")
		if event.pressed and event.scancode == KEY_2:
			SceneChanger.change_scene("res://Scene/Level_2.tscn")
		if event.pressed and event.scancode == KEY_3:
			SceneChanger.change_scene("res://Scene/Level_3.tscn")
		if event.pressed and event.scancode == KEY_4:
			SceneChanger.change_scene("res://Scene/Final Screen.tscn")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func music_manage():
	print(get_tree().get_current_scene().get_name())
	if get_tree().get_current_scene().get_name() == "Final Screen":
		MusicController.play_menu_music()
	else:
		MusicController.play_level_music()
