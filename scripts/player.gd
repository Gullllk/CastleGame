extends CharacterBody2D

@export var hp = 100
var damage = 50
var defend = 50

func _physics_process(delta):
	move_and_slide()
	
func _process(delta: float) -> void:
	pass
