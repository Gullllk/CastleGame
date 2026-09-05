extends Node2D 

  

@onready var hp_label = $Enemy/HPLabel 

  

@export var player: CharacterBody2D 

@export var oponent: StaticBody2D 

  

var current_character 

var game_over = false 

  

var player_hp: int = 100 

var oponent_hp: int = 100 

##idea: when i want to generalize turn based combat node i can try 

##exporting an hp variable form the script of the specific enemy 

  

func _ready() -> void: 

	hp_label.text =str(oponent_hp) 

  

func _on_attack_button_button_down() -> void: 
	if oponent_hp > 0: 

		oponent_hp = oponent_hp - 10 

		hp_label.text = str(oponent_hp) 

		 

  

func game_is_over(): 

	if player_hp or oponent_hp == 0: 

		game_over = true 

  

func who_won(): 

	if game_over == true: 

		if oponent_hp == 0: 

			print("You've won!") 

		elif player_hp == 0: 

			print("You've lost!") 
