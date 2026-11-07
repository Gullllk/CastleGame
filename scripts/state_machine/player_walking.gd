extends State
class_name PlayerWalking

var state_name = "walking"

@onready var walking_sound_1: AudioStreamPlayer = $"../../walking_sound_1"
@onready var walking_sound_2: AudioStreamPlayer = $"../../walking_sound_2"
@onready var walking_sound_3: AudioStreamPlayer = $"../../walking_sound_3"



@export var player : CharacterBody2D
@export var speed := 10
@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : Node

var step_frames : int

func _ready():
	pass

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


func play_sound():
	var random = randi_range(1,3)
	if random == 1:
		walking_sound_1.play()
	elif random == 2:
		walking_sound_2.play()
	elif random == 3:
		walking_sound_3.play()
	
	
	
	
	
func Physics_Update(_delta: float):
	player.velocity = state_machine.direction * speed
	
		
func Update(_delta: float):
	play_animation(state_machine.direction)
	if step_frames % 28 == 0:
		play_sound()
	step_frames += 1
	stopped_walking()

func _process(delta: float) -> void:
	pass

func Exit():
	animated_sprite_2d.stop()
		
