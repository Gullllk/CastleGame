extends Node 

@export var initial_state: State
@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

var current_state : State
var states: Dictionary = {}
var direction : Vector2

func _ready():
	for child in get_children():
		if child:
			states.set(child.name.to_lower(), child)
	if initial_state:
		# = if initial_state != null:
		initial_state.Enter()
		current_state = initial_state



func _process(delta: float) -> void:#
	if Input.is_action_pressed("go_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("go_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("go_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("go_left"):
		direction = Vector2.LEFT
	else: 
		direction = Vector2.ZERO
	
	if current_state:
		current_state.Update(delta)
	

	
	#print(direction, current_state)


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
	if current_state == new_state:
		return
	
	if current_state:
		#makes sure current_state exists before exiting it
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
	
	

func _on_walking_switch(new_state_name) -> void:
	state_transition(new_state_name)


func _on_idle_switch(new_state_name) -> void:
	state_transition(new_state_name)
