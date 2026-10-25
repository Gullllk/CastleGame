extends State
class_name PlayerDefault

var state_name = "default"

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var state_machine: Node


var direction: Vector2

func Enter():
	pass

func Exit():
	pass

func Physics_Update(_delta: float):
	pass
	
func _process(delta: float) -> void:
		if state_machine.current_state == state_machine.states.get("default"):
			if InputEvent:
				switch.connect(state_machine.state_transition("walking"))
				#switch.emit("default", "walking")
	
	
		
