extends Sprite

export(String, FILE, "*.png") var sprite_to_swap_path
export(String, FILE, "*.png") var sprite_new_path
onready var spriteToSwap = load(sprite_to_swap_path)
onready var spriteNew = load(sprite_new_path)

var grabbed = false

func switch_sprite(sprite):
	texture = sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event is InputEventMouseButton and grabbed == false:
		if event.button_index == BUTTON_LEFT and event.pressed:
			switch_sprite(spriteNew)
		else:
			switch_sprite(spriteToSwap)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func win():
	switch_sprite(spriteNew)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
