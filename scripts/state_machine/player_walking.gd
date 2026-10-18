extends State
class_name PlayerWalking
signal State_Transition 

@export var player : CharacterBody2D
@export var speed := 10
@export var animated_sprite_2d : AnimatedSprite2D

func Enter():
	pass
	
func get_direction():
	var direction : Vector2
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
	return direction
		
func play_animation(direction):
	if direction == Vector2.UP:
		animated_sprite_2d.play("walking_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("walking_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("walking_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("walking_right")
	
	
func Physics_Update(_delta: float):
	if player:
	#makes sure player != null
		var direction = get_direction()
		player.velocity = direction * speed
	
	if !Input:
		State_Transition.emit
		
func Update(_delta: float):
	if player:
		play_animation(get_direction())
		
