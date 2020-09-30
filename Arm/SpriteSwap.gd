extends Sprite
var spriteToSwap = preload("res://Hand_Arm.png")
var spriteNew = preload("res://ClosedHand_Arm.png")



func switch_sprite(sprite):
	texture = sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			switch_sprite(spriteNew)
		else:
			switch_sprite(spriteToSwap)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
