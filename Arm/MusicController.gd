extends Node

var level_music = load("res://Audio/Level_Music.wav")
var menu_music = load("res://Audio/Menu_Music.wav")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_level_music():
	if !$Music.playing:
		$Music.set_stream(level_music)
		$Music.play()

func play_menu_music():
	if !$Music.playing or !$Music.get_stream() == menu_music:
		$Music.set_stream(menu_music)
		$Music.play()
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
