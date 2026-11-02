extends Node 

@onready var enemy_hp_label = $EnemyHPLabel
@onready var player_hp_label = $PlayerHPLabel
@export var player: CharacterBody2D


var opponent : Enemy
var current_character 
var game_over : bool = false
var player_action : String
var opponent_next_attack_damage = opponent.damage
var player_next_attack_damage = player.damage


func _ready() -> void:
	for child in get_children():
		if child == Enemy:
			opponent = child
	
	enemy_hp_label.text = str(opponent.hp) 
	player_hp_label.text = str(player.hp)
	


func next_turn():
	
	if game_over:
		Exit()
	
	if current_character == opponent or current_character == null:
		current_character = player
	else:
		current_character = opponent
	
	if current_character == player:
		$Control/AttackButton.show()
		$Control/DefendButton.show()
		player_actions(player_action)
		if opponent.hp <= 0:
			game_over = true
			winner()
			return
		await get_tree().create_timer(2)
		next_turn()
	else:
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		var enemy_action = randi_range(0,2)
		if enemy_action:
			if enemy_action == 1:
				player.hp -= opponent_next_attack_damage
				opponent_next_attack_damage = opponent.damage
			else:
				player_next_attack_damage -= opponent.defend

			if player.hp <= 0:
				game_over = true
				winner()
				return
		await get_tree().create_timer(2)
		next_turn()
			
  
func winner():
	if game_over:
		if player.hp <= 0:
			print("The opponent has won")
			get_tree().change_scene_to_file("res://scenes/Level1.tscn")
		elif opponent.hp <= 0:
			print("You have won")
			
	Exit()

func _on_attack_button_button_down() -> void: 
	player_action = "attack"
	$Control/AttackButton.hide()
	$Control/DefendButton.hide()

func _on_defend_button_button_down() -> void:
	player_action = "defend"
	$Control/AttackButton.hide()
	$Control/DefendButton.hide()
	

func player_actions(action):
	if action == "attack":
		opponent.hp -= player_next_attack_damage
		player_next_attack_damage = player.damage
	
	if action == "defend":
		opponent_next_attack_damage -= player.defend

func Exit():
	pass
