extends Node

@onready var item_picked_up_sound: AudioStreamPlayer2D = $WorldElements/ItemPickedUp2


@export var player : CharacterBody2D
@export var current_hp_label : Label
@export var stats_gained_label : Label
@export var turn_based_combat : Node2D
@export var world : Node2D
@export var player_camera : Camera2D
@export var game_over_screen : Control

func _ready():
	current_hp_label.text = str(player.hp) + "/" + str(player.max_hp)
	stats_gained_label.hide()
	turn_based_combat.hide()
	turn_based_combat.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_screen.hide()
	game_over_screen.process_mode = Node.PROCESS_MODE_DISABLED
	
	
	
	
func when_item_picked_up(item):
	item.give_stats()
	current_hp_label.text = str(player.hp) + "/" + str(player.max_hp)
	item.queue_free()
	item_picked_up_sound.play()
	if item.item_type == item.type.health:
		stats_gained_label.text = "You gained 10 max health!"
	elif item.item_type == item.type.damage:
		player.damage += 10
		stats_gained_label.text = "Your damage increased by 10!"
	elif item.item_type == item.type.defend:
		player.defend += 10
		stats_gained_label.text = "Your defense increased by 10!"
	stats_gained_label.show()
	await get_tree().create_timer(2).timeout
	stats_gained_label.hide()

func _on_item_component_picked_up(item):
	when_item_picked_up(item)
	

func _on_item_component_2_picked_up(item):
	when_item_picked_up(item)


func _on_item_component_3_picked_up(item):
	when_item_picked_up(item)


func _on_slime_player_in_area() -> void:
	world.process_mode = Node.PROCESS_MODE_DISABLED
	world.hide()
	turn_based_combat.process_mode = Node.PROCESS_MODE_INHERIT
	turn_based_combat.show()
	player_camera.enabled = false


func _on_turn_based_combat_combat_over(won: bool) -> void:
	if won == true:
		pass
	elif won == false:
		game_over_screen.show()
		game_over_screen.process_mode = Node.PROCESS_MODE_INHERIT
