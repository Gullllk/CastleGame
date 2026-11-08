extends CharacterBody2D


@export var animated_sprite_2d : AnimatedSprite2D
@export var state_machine : Node

var max_hp : int
var damage : int 
var defend : int
var hp : int

func _ready():
	max_hp = GlobalPlayerData.max_hp
	damage = GlobalPlayerData.damage
	defend = GlobalPlayerData.defend
	hp = GlobalPlayerData.hp

func _physics_process(delta):
	move_and_slide()
	

func _on_tree_exiting() -> void:
	GlobalPlayerData.max_hp = max_hp
	GlobalPlayerData.hp = hp
	GlobalPlayerData.defend = defend
	GlobalPlayerData.damage = damage
