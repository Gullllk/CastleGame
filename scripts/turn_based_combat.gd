extends Node 

@onready var enemy_hp_label = $EnemyHPLabel
@onready var player_hp_label = $PlayerHPLabel
@export var player: CharacterBody2D


var opponent : Enemy
var current_character 
var game_over : bool = false
var player_action : String
var opponent_next_attack_damage : int
var player_next_attack_damage : int


func _ready() -> void:
	for child in get_children():
		if child is Enemy:
			opponent = child
	opponent_next_attack_damage = opponent.stats.damage
	player_next_attack_damage = player.damage
	print(opponent_next_attack_damage, player_next_attack_damage)
	
	enemy_hp_label.text = str(opponent.stats.hp) 
	player_hp_label.text = str(player.hp)
	
	next_turn()
	


func next_turn():
	
	if game_over:
		Exit()
	
	if current_character == opponent or current_character == null:
		current_character = player
	else:
		current_character = opponent
	
	if current_character == player:
		$"Opponent's Turn".hide()
		$Control/AttackButton.show()
		$Control/DefendButton.show()
		player_actions(player_action)
		if opponent.stats.hp <= 0:
			game_over = true
			winner()
			return
		await get_tree().create_timer(2)
		next_turn()
	else:
		$Control/AttackButton.hide()
		$Control/DefendButton.hide()
		$"Opponent's Turn".show()
		var enemy_action = randi_range(0,2)
		if enemy_action:
			if enemy_action == 1:
				pass
				player.hp -= opponent_next_attack_damage
				opponent_next_attack_damage = opponent.stats.damage
			else:
				pass
				player_next_attack_damage -= opponent.stats.defend

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
			#get_tree().change_scene_to_file("res://scenes/Level1.tscn")
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
		pass
		opponent.stats.hp -= player_next_attack_damage
		player_next_attack_damage = player.damage
	
	if action == "defend":
		pass
		opponent_next_attack_damage -= player.defend

func _process(delta):
	print(game_over)

func Exit():
	pass
