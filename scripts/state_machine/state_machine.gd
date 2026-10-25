extends Node 
@export var initial_state: State
# using @export decouples the initial state from the entitiy it's following,
#for example an entity or an enemy and allows you to pick a state directly
#from the inspector.
@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

var current_state : State
var states: Dictionary = {}
var direction: Vector2
var facing_direction: String

var actions: Dictionary = {
	"go_up": Input.is_action_pressed("go_up"),
	"go_down": Input.is_action_pressed("go_down"),
	"go_right": Input.is_action_pressed("go_right"),
	"go_left": Input.is_action_pressed("go_left")}


func _ready():
	for child in get_children():
		if child == State:
			states.set(child.name.to_lower(), child)
			#child.Activate_State.connect(state_transition)
	if initial_state:
		# = if initial_state != null:
		initial_state.Enter()
		current_state = initial_state
	
	for action in actions:
		action = actions.get(action)



func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
	print(current_state, direction, facing_direction)

	
	if "go_up":
		direction = Vector2.UP
		facing_direction = "back"
	elif "go_down":
		direction = Vector2.DOWN
		facing_direction = "front"
	elif "go_right":
		direction = Vector2.RIGHT
		facing_direction = "right"
	elif "go_left":
		direction = Vector2.LEFT
		facing_direction = "left"
	else: 
		direction = Vector2.ZERO
		facing_direction = "front"
		
	if player:
		animated_sprite_2d.play(current_state.state_name.to_lower()+"_"+facing_direction)
		
	
	

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func state_transition(new_state_name): 
	#takes the new state name as a string to then search in the dictionary
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
	# = if new_state == null
		return
		#stops the function if new_state is not found, instead of crashing
	
	if current_state:
		#makes sure current_state exists before exiting it
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
	
	

		
	
