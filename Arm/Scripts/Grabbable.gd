extends RigidBody2D

var grabbed = false
export(NodePath) var node
onready var handRB = get_node(node)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	if grabbed:
		self.position = get_node("../Arm/Joint1/Joint2/Hand/GrabPos").global_position
		self.rotation = get_node("../Arm/Joint1/Joint2/Hand").global_rotation
		sleeping = true
	else:
		sleeping = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_action_pressed("mouse_left"):
			remove_collision_exception_with(handRB)
			print("checking collisions")
			var bodies = $Detector.get_overlapping_bodies()
			for b in bodies:
				print(b.name)
				if b.name == "HandRB" and grabbed == false:
					grabbed = true;
					var torch_sfx = load("res://Audio/Grab0" + str((randi() % 6 + 1)) + ".wav")
					$Torch2/Grab_Sound.set_stream(torch_sfx)
					$Torch2/Grab_Sound.play()
		if event.button_index == BUTTON_LEFT and event.is_action_released("mouse_left"):
			add_collision_exception_with(handRB)
			if grabbed:
				grabbed = false;
				var LV = get_node("../Arm/Joint1/Joint2/Hand/HandRB").get_linear_velocity().normalized()
			
				apply_impulse(Vector2(0,0), LV * 1000)
				set_angular_velocity(LV.length() * 4)
				add_collision_exception_with(handRB)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_collision_exception_with(handRB)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
