extends RigidBody2D

var grabbed = false
onready var handRB = get_node("../Arm/Joint1/Joint2/Hand/HandRB")

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
					print("grabbed item")
		if event.button_index == BUTTON_LEFT and event.is_action_released("mouse_left"):
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
