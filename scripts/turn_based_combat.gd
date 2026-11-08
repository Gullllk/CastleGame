extends Node 

@onready var enemy_hp_label = $EnemyHPLabel
@onready var player_hp_label = $PlayerHPLabel
@export var player: CharacterBody2D
@export var level : Node
@export var action_label : Label 

signal combat_over(won : bool)


var opponent : Enemy
var game_over : bool = false
var player_action : String
var opponent_next_attack_damage : int
var player_next_attack_damage : int
var is_player_turn : bool
var is_opponent_turn : bool
var hp_after_combat : int


func _ready() -> void:
	player.process_mode = Node.PROCESS_MODE_DISABLED
	for child in get_children():
		if child is Enemy:
			opponent = child
	player_next_attack_damage = player.damage
	opponent_next_attack_damage = opponent.stats.damage
	
	enemy_hp_label.text = str(opponent.stats.hp) 
	player_hp_label.text = str(player.hp)
	
	is_player_turn = true
	$"Opponent's Turn".hide()
	action_label.hide()
	combat_over.emit(true)
	
	

func opponent_turn():
	if game_over == false:
		is_player_turn = false
		action_label.hide()
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		$"Opponent's Turn".show()
		await get_tree().create_timer(2).timeout
		$"Opponent's Turn".hide()
		var enemy_action = randi_range(0,1)
		print(enemy_action)
		if enemy_action == 0:
			#attack
			
			action_label.text = str(opponent.stats.enemy_name) + " did " + str(opponent_next_attack_damage) + " damage!"
			
			player.hp -= opponent_next_attack_damage
			if player.hp <0:
				player.hp = 0
			opponent_next_attack_damage = opponent.stats.damage
		elif enemy_action == 1:
			#defend
			player_next_attack_damage -= opponent.stats.defend
			if player_next_attack_damage < 0:
				player_next_attack_damage = 0
			
			action_label.text = str(opponent.stats.enemy_name) + " will defend against " + str(opponent.stats.defend) + " damage."
		
		player_hp_label.text = str(player.hp)
		action_label.show()
		await get_tree().create_timer(2).timeout
		action_label.hide()
		
	if player.hp <= 0:
		game_over = true
		winner()
		return
	else:
		$Control/AttackButton.show()
		$Control/DefendButton.show()
		$"Opponent's Turn".hide()
		is_player_turn = true

  
func winner():
	var won : bool
	print("game_over")
	if game_over:
		if player.hp <= 0:
			won = false
			print("The opponent has won")
		elif opponent.stats.hp <= 0:
			won = true
			print("You have won")
		hp_after_combat = player.hp
		combat_over.emit(won)

func _on_attack_button_button_down() -> void: 
	if is_player_turn == true:
		player_actions("attack")
		enemy_hp_label.text = str(opponent.stats.hp) 
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		await get_tree().create_timer(2).timeout
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
		await get_tree().create_timer(2).timeout
		if opponent.stats.hp >0:
			opponent_turn()
		else:
			game_over = true
			winner()
	

func player_actions(action):
	if action == "attack" or action == "defend":
		if action == "attack":

			action_label.text = "You did " + str(player_next_attack_damage) + " damage!"
			action_label.show()
			
			opponent.stats.hp -= player_next_attack_damage
			if opponent.stats.hp <0:
				opponent.stats.hp = 0
			player_next_attack_damage = player.damage
		
		elif action == "defend":
			
			action_label.text = "You will defend against " + str(player.defend) + " damage."
			action_label.show()
			print(action_label.text)
			
			opponent_next_attack_damage -= player.defend
			if opponent_next_attack_damage <0:
				opponent_next_attack_damage = 0
		
		is_player_turn = false
	


func _process(delta):
	pass

func Exit():
	pass
