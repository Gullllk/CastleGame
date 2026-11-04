extends State
class_name PlayerWalking

var state_name = "walking"

@export var player : CharacterBody2D
@export var speed := 10
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : Node


func Enter():
	pass

func stopped_walking():
	var inputs = [Input.is_action_just_released("go_up"), 
	Input.is_action_just_released("go_down"),
	Input.is_action_just_released("go_right"),
	Input.is_action_just_released("go_left")]
	
	for input in inputs:
		if input:
			switch.emit("idle")
			return
	
	
		
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
	player.velocity = state_machine.direction * speed
	
		
func Update(_delta: float):
	play_animation(state_machine.direction)
	stopped_walking()

func _process(delta: float) -> void:
	pass

func Exit():
	animated_sprite_2d.stop()
		
