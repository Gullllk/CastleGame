extends Node

@export var player : CharacterBody2D
@export var current_hp_label : Label

func _ready():
	current_hp_label.text = str(player.hp) + "/" + str(player.max_hp)
