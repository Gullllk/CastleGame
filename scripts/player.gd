extends CharacterBody2D


@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : Node

var hp = 1
var damage : int = 30
var defend : int = 30
var max_hp = hp

func _ready():
	pass

func _physics_process(delta):
	move_and_slide()
	
