extends RigidBody2D

var grabbed = false
var game_over = false

## Player Hand Variables
onready var handRB = self.get_owner().find_node("Player_HandRB")
onready var hand_node_offset = self.get_owner().find_node("Player_GrabPos")

##NPC Hand Variables
onready var npc_hand_sprite = self.get_owner().find_node("NPC_Hand_Sprite")
onready var arm = self.get_owner().find_node("NPC_arm")
onready var hand_NPC = self.get_owner().find_node("Hand_NPC_RB")
onready var hand_NPC_offset = self.get_owner().find_node("NPC_GrabPos")

export(float) var lower_bounds = 700

var grabbing_node = handRB
var grabbing_node_offset = hand_node_offset
var reset_state = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	if game_over:
		self.rotation = grabbing_node.global_rotation
		self.position = grabbing_node_offset.global_position
		return
	if grabbed:
		self.position = grabbing_node_offset.global_position
		self.rotation = grabbing_node.global_rotation
		sleeping = true
	if self.position.y > lower_bounds:
		reset_state = true
	else:
		sleeping = false
		var collisions = get_colliding_bodies()
		for c in collisions:
			print(c.name)
			if	c.name == hand_NPC.name:
				grabbed = true
				game_over = true
				play_random_grab()
				grabbing_node = hand_NPC
				grabbing_node_offset = hand_NPC_offset
				
				npc_hand_sprite.win()
				arm.grab_torch()
				get_tree().get_root().get_node("Level").level_complete()
		
				

func _input(event):
	if event is InputEventMouseButton and !game_over:
		if event.button_index == BUTTON_LEFT and event.is_action_pressed("mouse_left"):
			remove_collision_exception_with(handRB)
			print("checking collisions")
			var bodies = $Detector.get_overlapping_bodies()
			for b in bodies:
				print(b.name)
				if b.name == handRB.name and grabbed == false:
					grabbed = true;
					play_random_grab();
					grabbing_node = handRB
					grabbing_node_offset = hand_node_offset
				
					
		if event.button_index == BUTTON_LEFT and event.is_action_released("mouse_left"):
			add_collision_exception_with(handRB)
			
			if grabbed:
				grabbed = false;
				var LV = grabbing_node.get_linear_velocity().normalized()
			
				apply_impulse(Vector2(0,0), LV * 1000)
				set_angular_velocity(LV.length() * 4)
				add_collision_exception_with(handRB)
				

# Called when the node enters the scene tree for the first time.
func _ready():
	add_collision_exception_with(handRB)
	
	grabbing_node = handRB
	grabbing_node_offset = grabbing_node_offset
	pass # Replace with function body.
	
func play_random_grab():
	var torch_sfx = load("res://Audio/Grab0" + str((randi() % 6 + 1)) + ".wav")
	$Torch2/Grab_Sound.set_stream(torch_sfx)
	$Torch2/Grab_Sound.play()

func _integrate_forces(state):
	if reset_state:
		state.set_angular_velocity(0)
		state.set_linear_velocity(Vector2.DOWN)
		state.transform = Transform2D(0.0, Vector2(300, -300))
		reset_state = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
