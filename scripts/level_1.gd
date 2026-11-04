extends Node

@export var turn_based_combat : Node2D
@export var world : Node2D
@export var player: CharacterBody2D
@export var enemy : StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_enemy_area_component_body_entered(body: Node2D) -> void:
	if body == player:
		print("player entered")
		world.process_mode = Node.PROCESS_MODE_DISABLED
		world.hide()
		turn_based_combat.process_mode = Node.PROCESS_MODE_INHERIT
		turn_based_combat.show()
		
		


func _on_turn_based_combat_combat_over(won: bool) -> void:
	if won == true:
		turn_based_combat.process_mode = Node.PROCESS_MODE_DISABLED
		turn_based_combat.hide()
		world.process_mode = Node.PROCESS_MODE_INHERIT
		world.show()
		enemy.queue_free()
