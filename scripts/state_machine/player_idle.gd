extends State
class_name PlayerIdle

var state_name = "idle"

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var state_machine: Node

var speed = 0


func stopped_idle():
	var inputs = [
	Input.is_action_pressed("go_up"),
	Input.is_action_pressed("go_down"),
	Input.is_action_pressed("go_right"),
	Input.is_action_pressed("go_left")]
	
	for input in inputs:
		if input:
			switch.emit("walking")
			return

func play_animation(direction):
	if direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")

func Enter():
	pass

func Exit():
	animated_sprite_2d.stop()


func Update(_delta: float):
	play_animation(state_machine.direction)
	stopped_idle()

func Physics_Update(_delta: float):
	player.velocity = state_machine.direction * speed
	
	
		
