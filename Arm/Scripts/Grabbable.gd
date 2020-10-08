extends RigidBody2D

var grabbed = false
var game_over = false

export(NodePath) var hand_sprite_node_path
onready var hand_sprite = get_node(hand_sprite_node_path)

export(NodePath) var arm_node_path
onready var arm = get_node(arm_node_path)

export(NodePath) var hand_node_path
onready var handRB = get_node(hand_node_path)

export(NodePath) var hand_node_offset_path
onready var hand_node_offset = get_node(hand_node_offset_path)

export(NodePath) var hand_NPC_node_path
onready var hand_NPC = get_node(hand_NPC_node_path)

export(NodePath) var hand_NPC_node_offset_path
onready var hand_NPC_offset = get_node(hand_NPC_node_offset_path)

export(float) var lower_bounds = get_viewport_rect().size.y + 100

var grabbing_node
var grabbing_node_offset
var reset_state = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
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
			if	c.name == "Hand_NPC_RB":
				grabbed = true
				game_over = true
				play_random_grab()
				grabbing_node = hand_NPC
				grabbing_node_offset = hand_NPC_offset
				hand_sprite.win()
				arm.grab_torch()
		
				

func _input(event):
	if event is InputEventMouseButton and !game_over:
		if event.button_index == BUTTON_LEFT and event.is_action_pressed("mouse_left"):
			remove_collision_exception_with(handRB)
			print("checking collisions")
			var bodies = $Detector.get_overlapping_bodies()
			for b in bodies:
				print(b.name)
				if b.name == "HandRB" and grabbed == false:
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
	
	grabbing_node = hand_node_path
	grabbing_node_offset = hand_NPC_node_offset_path
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
