extends TextureButton
export(String) var Target_URL

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Twitter_Button_pressed():
	OS.shell_open(Target_URL)


func _on_Twitter_Button2_pressed():
	pass # Replace with function body.
