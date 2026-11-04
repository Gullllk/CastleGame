extends Node 

@onready var enemy_hp_label = $EnemyHPLabel
@onready var player_hp_label = $PlayerHPLabel
@export var player: CharacterBody2D
@export var main_scene : Node

signal combat_over(won : bool)


var opponent : Enemy
var game_over : bool = false
var player_action : String
var opponent_next_attack_damage : int
var player_next_attack_damage : int
var is_player_turn : bool
var is_opponent_turn : bool


func _ready() -> void:
	for child in get_children():
		if child is Enemy:
			opponent = child
	player_next_attack_damage = player.damage
	opponent_next_attack_damage = opponent.stats.damage
	
	enemy_hp_label.text = str(opponent.stats.hp) 
	player_hp_label.text = str(player.hp)
	
	is_player_turn = true
	$"Opponent's Turn".hide()
	#next_turn()
	

func opponent_turn():
	if game_over == false:
		is_opponent_turn = true
		is_player_turn = false
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		$"Opponent's Turn".show()
		var enemy_action = randi_range(0,1)
		print(enemy_action)
		if enemy_action == 0:
			#attack
			player.hp -= opponent_next_attack_damage
			opponent_next_attack_damage = opponent.stats.damage
		elif enemy_action == 1:
			#defend
			player_next_attack_damage -= opponent.stats.defend
			if player_next_attack_damage < 0:
				player_next_attack_damage = 0
		await get_tree().create_timer(2).timeout
		player_hp_label.text = str(player.hp)
	if player.hp <= 0:
		game_over = true
		winner()
		return
	else:
		$Control/AttackButton.show()
		$Control/DefendButton.show()
		$"Opponent's Turn".hide()
		is_opponent_turn = false
		is_player_turn = true
		
				


#func next_turn():
	#
	#if game_over:
		#winner()
		#return
	#
	#if current_character == null:
		#current_character = player
	#elif current_character == opponent:
		#current_character = player
	#elif current_character == player:
		#current_character = opponent
	#
	#print(current_character)
	#
	#if current_character == player:
		#is_player_turn = false
		#is_opponent_turn = true
		#
		#while is_player_turn == false:
			#$"Opponent's Turn".hide()
			#$Control/AttackButton.show()
			#$Control/DefendButton.show()
			#player_actions(player_action)
			#await get_tree().create_timer(2)
			#if opponent.stats.hp <= 0:
				#game_over = true
				#winner()
				#return
		
	#elif current_character == opponent:
		#is_player_turn = true
		#is_opponent_turn = false
		#
		#$Control/AttackButton.hide()
		#$Control/DefendButton.hide()
		#$"Opponent's Turn".show()
		#var enemy_action = randi_range(0,2)
		#if enemy_action:
			#if enemy_action == 1:
				#player.hp -= opponent_next_attack_damage
				#opponent_next_attack_damage = opponent.stats.damage
			#else:
				#player_next_attack_damage -= opponent.stats.defend
			#await get_tree().create_timer(2)
			#if player.hp <= 0:
				#game_over = true
				#winner()
				#return
			#is_opponent_turn = true

		#next_turn()
			
  
func winner():
	var won : bool
	if game_over:
		if player.hp <= 0:
			won = false
			print("The opponent has won")
		elif opponent.stats.hp <= 0:
			won = true
			print("You have won")
		combat_over.emit(won)
		
	Exit()

func _on_attack_button_button_down() -> void: 
	if is_player_turn == true:
		player_actions("attack")
		enemy_hp_label.text = str(opponent.stats.hp) 
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		if opponent.stats.hp > 0:
			opponent_turn()
		else:
			game_over = true
			winner()

func _on_defend_button_button_down() -> void:
	if is_player_turn == true:
		player_actions("defend")
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		if opponent.stats.hp >0:
			opponent_turn()
		else:
			game_over = true
			winner()
	

func player_actions(action):
	if action == "attack" or action == "defend":
		
		if action == "attack":
			opponent.stats.hp -= player_next_attack_damage
			player_next_attack_damage = player.damage
		
		elif action == "defend":
			opponent_next_attack_damage -= player.defend
			if opponent_next_attack_damage <0:
				opponent_next_attack_damage = 0
		
		is_player_turn = false
		is_opponent_turn = true
	


func _process(delta):
	pass

func Exit():
	pass
