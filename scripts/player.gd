extends CharacterBody2D

const SPEED = 300
var player_dir: Vector2 = Vector2.ZERO

func player_direction():
	if Input.is_action_pressed("go_up"):
		player_dir = Vector2.UP
		print("move up")
	elif Input.is_action_pressed("go_down"):
		player_dir = Vector2.DOWN
	elif Input.is_action_pressed("go_right"):
		player_dir = Vector2.RIGHT
	elif Input.is_action_pressed("go_left"):
		player_dir = Vector2.LEFT
	else: 
		player_dir = Vector2.ZERO
	


func _physics_process(delta):
	velocity = player_dir * SPEED
	player_direction()
	move_and_slide()
	
