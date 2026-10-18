extends Node 
@export var initial_state: State
# using @export decouples the initial state from the entitiy it's following,
#for example an entity or an enemy and allows you to pick a state directly
#from the inspector.

var current_state : State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child == State:
			states.set(child.name.to_lower(), child)
			child.Activate_State.connect(state_transition)
	if initial_state:
		# = if initial_state != null:
		initial_state.Enter()
		current_state = initial_state
			
			

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
	

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func state_transition(state, new_state_name):
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
	
	

		
	
