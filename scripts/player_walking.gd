extends State
class_name PlayerWalking

@export var player : CharacterBody2D
@export var speed := 10

var direction : Vector2

func Enter():
	Activate_State.emit()
	
func player_direction():
	if Input.is_action_pressed("go_up"):
		direction = Vector2.UP
		print("move up")
	elif Input.is_action_pressed("go_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("go_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("go_left"):
		direction = Vector2.LEFT
	else: 
		direction = Vector2.ZERO
	
	
func Physics_Update(_delta: float):
	if player:
	#makes sure player != null
		player_direction()
		player.velocity = direction * speed
