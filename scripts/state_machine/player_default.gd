extends State
class_name PlayerDefault

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

var direction: Vector2

func Enter():
	animated_sprite_2d.play("default_front")

func Exit():
	pass

	
func Physics_Update(_delta: float):
	pass
	
func Update(_delta: float):
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
	if player:
		play_animation(direction)
