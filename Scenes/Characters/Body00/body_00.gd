class_name Player extends CharacterBody2D

# @export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var animated_sprite = $AnimatedSprite2D
@onready var state_machine = animation_tree.get("parameters/playback") # allows changing animations

var move_speed : float

var last_velocity : Vector2 = Vector2.ZERO # var to control the flip_h for left sprites

func _ready():
	update_animation_parameters(starting_direction)
	move_speed = 100 * GameState.world_scale
	
func _physics_process(delta: float) -> void:
	
	# No permitir input mientras haya diálogo
	if not GameState.can_player_act():
		velocity = Vector2.ZERO
		return  
	
	# Get input directions
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	# Update animation
	update_animation_parameters(input_direction)
	
	# Update velocity
	velocity = input_direction * move_speed # * GameState.world_scale
	
	# Move and slide funciton uses velocity of character body to move character on map
	move_and_slide() # if you collide to a wall but you can still slide, you will slide
	
	# Change animation
	pick_new_state() 
	
func update_animation_parameters(move_input : Vector2):
	# Don't change animation parameters if there is no move input
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
		
func pick_new_state():
	# print(velocity)
	
	# We update the state depending if we are moving the player or not
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
		last_velocity = velocity # Update the last velocity
	else:
		state_machine.travel("Idle")
	
	# We get the animated sprite in order to flip if we are performing a left side sprite (walk or idle)
	var animation = animated_sprite.get("animation")
	animated_sprite.flip_h = (last_velocity.x == -move_speed) # if x axis corresponds to -speed == left sprite --> TRUE
