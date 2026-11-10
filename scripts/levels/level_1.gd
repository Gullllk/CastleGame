extends Level



@export var turn_based_combat : Node2D
@export var world : Node2D
@export var player: CharacterBody2D
@export var enemy : StaticBody2D
@export var health_item : Node2D
@export var health_gain_text : Label
@export var current_hp_label: Label
@export var game_over_screen : Control
@export var item_picked_up_sound : AudioStreamPlayer2D

var next_level = "res://scenes//levels/level_2.tscn"



func _ready():
	current_hp_label.text = "HP: " + str(player.hp) + "/" + str(player.max_hp)
	turn_based_combat.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_screen.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_screen.hide()
	

func _on_enemy_area_component_body_entered(body: Node2D) -> void:
	if body == player:
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
		health_item.show()
		player.hp = turn_based_combat.hp_after_combat
		current_hp_label.text = "HP: " + str(player.hp) + "/" + str(player.max_hp)
		player.state_machine.state_transition("idle")
	else:
		turn_based_combat.process_mode = Node.PROCESS_MODE_DISABLED
		turn_based_combat.hide()
		game_over_screen.process_mode = Node.PROCESS_MODE_INHERIT
		game_over_screen.show()
		game_over_screen.container.show()


func _on_door_component_open_door() -> void:
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file(next_level)


func _on_health_item_picked_up() -> void:
	health_item.queue_free()
	item_picked_up_sound.play()
	player.max_hp += 10
	player.hp += 10
	
	health_gain_text.show()
	current_hp_label.text = "HP: " + str(player.hp) + "/" + str(player.max_hp)
	await get_tree().create_timer(2).timeout
	health_gain_text.hide()
